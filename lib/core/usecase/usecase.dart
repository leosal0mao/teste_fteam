import 'package:either_dart/either.dart';
import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}

class Params {
  final int page;
  final String? name;
  Params({required this.page, this.name});
}
