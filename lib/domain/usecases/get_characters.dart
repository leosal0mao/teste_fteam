import 'package:either_dart/either.dart';
import '../../core/error/failure.dart';
import '../../core/usecase/usecase.dart';
import '../entities/character.dart';
import '../repositories/character_repository.dart';

class GetCharacters extends UseCase<List<Character>, Params> {
  final CharacterRepository repository;

  GetCharacters(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(Params params) async {
    return await repository.getCharacters(page: params.page, name: params.name);
  }
}
