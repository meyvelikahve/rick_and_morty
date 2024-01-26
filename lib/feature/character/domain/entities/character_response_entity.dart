import 'package:rick_morty_api/feature/character/domain/entities/character_entity.dart';
import 'package:rick_morty_api/feature/character/domain/entities/character_info_entity.dart';

class CharacterResponseEntity {
  CharacterInfoEntity? info;
  List<CharacterEntity>? results;

  CharacterResponseEntity({
    this.info,
    this.results,
  });
}
