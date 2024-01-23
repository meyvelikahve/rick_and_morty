import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/common/extention/http_response_error.dart';
import 'package:rick_morty_api/feature/character/data/api/character_api_service.dart';
import 'package:rick_morty_api/feature/character/data/api/icharacter_api_service.dart';
import 'package:rick_morty_api/feature/character/data/dto/character_response.dart';
import 'package:rick_morty_api/feature/character/data/repository/icharacter_repository.dart';

final characterRepositorProvider = Provider<ICharacterRepository>((ref) {
  ICharacterApiService characterApiService =
      ref.watch(characterApiServiceProvider);
  return CharacterRepository(characterApiService);
});

class CharacterRepository implements ICharacterRepository {
  final ICharacterApiService _characterService;
  CharacterRepository(
    this._characterService,
  );

  @override
  Future<CharacterResponse> getChacterResponse() async {
    try {
      var response = await _characterService.getCharacterResponse();

      if (response.statusCode != HttpStatus.ok) {
        throw Failure(message: response.httpResponseError());
      }

      final json = jsonDecode(response.body);

      return CharacterResponse.fromJson(json);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<CharacterResult> getCharacterWithId(int id) async {
    try {
      var response = await _characterService.getCharacterWithId(id);

      if (response.statusCode != HttpStatus.ok) {
        throw Failure(message: response.httpResponseError());
      }

      final json = jsonDecode(response.body);

      return CharacterResult.fromJson(json);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
