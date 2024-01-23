import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/feature/character/application/icharacter_service.dart';
import 'package:rick_morty_api/feature/character/data/dto/character_response.dart';
import 'package:rick_morty_api/feature/character/data/repository/character_repository.dart';
import 'package:rick_morty_api/feature/character/data/repository/icharacter_repository.dart';
import 'package:rick_morty_api/feature/character/domain/model/character.dart';

final characterServiceProvider = Provider<ICharacterService>((ref) {
  ICharacterRepository characterRepository =
      ref.watch(characterRepositorProvider);
  return CharacterService(characterRepository);
});

class CharacterService implements ICharacterService {
  final ICharacterRepository _characterRepository;
  CharacterService(this._characterRepository);

  @override
  Future<List<Character>> getCharacterList() async {
    try {
      var response = await _characterRepository.getChacterResponse();
      return responseToCharacterList(response);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<Character> getCharacterWithId(int id) async {
    try {
      var response = await _characterRepository.getCharacterWithId(id);
      return characterResultToCharacter(response);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  characterResultToCharacter(CharacterResult result) {
    return Character(
        id: result.id,
        name: result.name,
        status: result.status,
        species: result.species,
        type: result.type,
        gender: result.gender,
        origin: result.origin,
        location: result.location,
        image: result.image,
        episode: result.episode,
        url: result.url,
        created: result.created);
  }

  List<Character> responseToCharacterList(CharacterResponse characterResponse) {
    List<CharacterResult> characterResultList = characterResponse.results;
    List<Character> characterList = [];

    for (var result in characterResultList) {
      characterList.add(characterResultToCharacter(result));
    }

    return characterList;
  }
}
