import 'package:rick_morty_api/feature/character/domain/model/character.dart';

abstract class ICharacterService {
  Future<List<Character>> getCharacterList();
  Future<Character> getCharacterWithId(int id);
  Future<Character> getCharacterWithUrl(String url);
}
