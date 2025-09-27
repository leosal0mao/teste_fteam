import 'package:flutter/material.dart';
import 'package:teste_fteam/core/usecase/usecase.dart';
import '../../domain/entities/character.dart';
import '../../domain/usecases/get_characters.dart';

// O enum de estado continua útil para o carregamento inicial
enum ViewState { initial, loading, loaded, error }

class CharacterProvider extends ChangeNotifier {
  final GetCharacters getCharactersUseCase;
  CharacterProvider({required this.getCharactersUseCase});

  ViewState _state = ViewState.initial;
  ViewState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _isLoadingNextPage = false;
  bool get isLoadingNextPage => _isLoadingNextPage;

  // --- DADOS ---

  String _searchQuery = '';
  List<Character> _characters = [];
  List<Character> get characters => _characters;

  int _currentPage = 1;
  bool _hasReachedMax = false;

  // --- MÉTODOS ---

  Future<void> fetchFirstPage({String? query}) async {
    _searchQuery = query ?? ''; // Atualiza o termo de busca
    _characters = []; // Limpa a lista para novos resultados
    _currentPage = 1; // Reseta a página
    _hasReachedMax = false; // Reseta o controle de página máxima

    _state = ViewState.loading;
    notifyListeners();

    final result = await getCharactersUseCase(
      Params(page: _currentPage, name: _searchQuery),
    );

    result.fold(
      (failure) {
        _errorMessage = 'Falha ao carregar os personagens.';
        _state = ViewState.error;
      },
      (characterList) {
        _characters = characterList;
        _state = ViewState.loaded;
        if (characterList.isNotEmpty) {
          _currentPage++;
        }
        if (characterList.length < 20) {
          _hasReachedMax = true;
        }
      },
    );
    notifyListeners();
  }

  Future<void> fetchNextPage() async {
    if (_isLoadingNextPage || _hasReachedMax) return;

    _isLoadingNextPage = true;
    notifyListeners();

    final result = await getCharactersUseCase(
      Params(page: _currentPage, name: _searchQuery),
    );

    result.fold(
      (failure) {
        _hasReachedMax = true;
      },
      (newCharacterList) {
        if (newCharacterList.isEmpty || newCharacterList.length < 20) {
          _hasReachedMax = true;
        }
        _characters.addAll(newCharacterList);
        _currentPage++;
      },
    );

    _isLoadingNextPage = false;
    notifyListeners();
  }
}
