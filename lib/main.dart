import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teste_fteam/app.dart';
import 'package:teste_fteam/data/datasources/character_remote_datasource.dart';
import 'package:teste_fteam/data/repositories/character_repository_impl.dart';
import 'package:teste_fteam/domain/usecases/get_characters.dart';

void main() {
  final client = http.Client();
  final remoteDataSource = CharacterRemoteDataSourceImpl(client: client);
  final repository = CharacterRepositoryImpl(
    remoteDataSource: remoteDataSource,
  );
  final getCharactersUseCase = GetCharacters(repository);

  runApp(App(getCharactersUseCase: getCharactersUseCase));
}
