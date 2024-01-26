import 'package:rick_morty_api/feature/character/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<List<CharacterEntity>> getAllCharacters({int? page});
  Future<CharacterEntity> getCharacterDetail(int id);
}
