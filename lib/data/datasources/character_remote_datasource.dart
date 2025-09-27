import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getCharacters({required int page, String? name});
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final http.Client client;
  final _baseUrl = 'https://rickandmortyapi.com/api';

  CharacterRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CharacterModel>> getCharacters({
    required int page,
    String? name,
  }) async {
    var url = '$_baseUrl/character?page=$page';
    if (name != null && name.isNotEmpty) {
      url += '&name=$name';
    }

    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => CharacterModel.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Server Exception: Failed to load characters');
    }
  }
}
