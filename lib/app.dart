import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_fteam/domain/usecases/get_characters.dart';
import 'package:teste_fteam/presentation/pages/character_list_page.dart';
import 'package:teste_fteam/presentation/providers/character_provider.dart';

class App extends StatelessWidget {
  final GetCharacters getCharactersUseCase;

  const App({super.key, required this.getCharactersUseCase});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          CharacterProvider(getCharactersUseCase: getCharactersUseCase),
      child: MaterialApp(
        title: 'Rick and Morty App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const CharacterListPage(),
      ),
    );
  }
}
