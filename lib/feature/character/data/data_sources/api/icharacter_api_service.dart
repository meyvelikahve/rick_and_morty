import 'package:rick_morty_api/feature/character/data/models/character_model.dart';

abstract class ICharacterApiService {
  Future<List<CharacterDto>> getAllCharacters({int? page});
  Future<CharacterDto> getCharacterDetail(int id);
}
