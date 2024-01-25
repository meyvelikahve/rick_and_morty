import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/core/resources/data_state.dart';
import 'package:rick_morty_api/feature/character/data/data_sources/api/character_api_service.dart';
import 'package:rick_morty_api/feature/character/data/data_sources/api/icharacter_api_service.dart';
import 'package:rick_morty_api/feature/character/data/models/character_model.dart';
import 'package:rick_morty_api/feature/character/data/models/character_response.dart';
import 'package:rick_morty_api/feature/character/domain/repository/icharacter_repository.dart';

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
  Future<DataState<CharacterResponse>> getCharacters() async {
    try {
      var response = await _characterService.getCharacters();

      if (response.statusCode == HttpStatus.ok) {
        var decodedBody = jsonDecode(response.body);
        CharacterResponse characterResponse =
            CharacterResponse.fromJson(decodedBody);
        return DataSuccess(characterResponse);
      } else {
        return DataFailed(Failure(message: 'Http status is not ok.'));
      }
    } catch (e) {
      return DataFailed(Failure(message: e.toString()));
    }
  }

  @override
  Future<DataState<CharacterModel>> getCharacterDetail(int id) async {
    try {
      var response = await _characterService.getCharacterDetail(id);

      if (response.statusCode == HttpStatus.ok) {
        var decodedBody = jsonDecode(response.body);
        CharacterModel characterResponse = CharacterModel.fromJson(decodedBody);
        return DataSuccess(characterResponse);
      } else {
        return DataFailed(Failure(message: 'Http status is not ok.'));
      }
    } catch (e) {
      return DataFailed(Failure(message: e.toString()));
    }
  }
}
