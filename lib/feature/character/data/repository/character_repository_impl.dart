import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/feature/character/data/data_sources/api/character_api_service.dart';
import 'package:rick_morty_api/feature/character/data/data_sources/api/icharacter_api_service.dart';
import 'package:rick_morty_api/feature/character/data/models/character_model.dart';
import 'package:rick_morty_api/feature/character/data/models/character_model_extention.dart';
import 'package:rick_morty_api/feature/character/domain/entities/character_entity.dart';
import 'package:rick_morty_api/feature/character/domain/repository/character_repository.dart';

final characterRepositorProvider = Provider<CharacterRepository>((ref) {
  ICharacterApiService characterApiService =
      ref.read(characterApiServiceProvider);
  return CharacterRepositoryImpl(characterApiService);
});

class CharacterRepositoryImpl implements CharacterRepository {
  final ICharacterApiService _characterService;
  CharacterRepositoryImpl(
    this._characterService,
  );

  @override
  Future<List<CharacterEntity>> getAllCharacters({int? page}) async {
    try {
      List<CharacterDto> dtoList =
          await _characterService.getAllCharacters(page: page);

      List<CharacterEntity> characterList = [];

      for (var dto in dtoList) {
        // from extention

        characterList.add(dto.toCharacterEntity());
      }

      return characterList;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<CharacterEntity> getCharacterDetail(int id) async {
    try {
      CharacterDto characterDto =
          await _characterService.getCharacterDetail(id);

      return characterDto.toCharacterEntity();
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
