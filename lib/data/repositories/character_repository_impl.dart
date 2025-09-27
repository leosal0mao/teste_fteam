import 'package:either_dart/either.dart';
import 'package:teste_fteam/data/datasources/character_remote_datasource.dart';
import '../../core/error/failure.dart';
import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;
  final Map<int, List<Character>> _characterCache = {};

  CharacterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Character>>> getCharacters({
    required int page,
    String? name,
  }) async {
    final isSearching = name != null && name.isNotEmpty;
    if (isSearching) {
      _characterCache.clear();
    } else {
      if (_characterCache.containsKey(page)) {
        return Right(_characterCache[page]!);
      }
    }

    try {
      final remoteCharacters = await remoteDataSource.getCharacters(
        page: page,
        name: name,
      );

      if (!isSearching) {
        _characterCache[page] = remoteCharacters;
      }
      return Right(remoteCharacters);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
