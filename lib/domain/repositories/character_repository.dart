import 'package:either_dart/either.dart';
import '../../core/error/failure.dart';
import '../entities/character.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<Character>>> getCharacters({
    required int page,
    String? name,
  });
}
