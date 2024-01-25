import 'package:rick_morty_api/core/resources/data_state.dart';
import 'package:rick_morty_api/feature/character/data/models/character_model.dart';
import 'package:rick_morty_api/feature/character/data/models/character_response.dart';

abstract class ICharacterRepository {
  Future<DataState<CharacterResponse>> getCharacters();
  Future<DataState<CharacterModel>> getCharacterDetail(int id);
}
