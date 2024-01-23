import 'package:rick_morty_api/feature/character/data/dto/character_response.dart';

abstract class ICharacterRepository {
  Future<CharacterResponse> getChacterResponse();
  Future<CharacterResult> getCharacterWithId(int id);
}
