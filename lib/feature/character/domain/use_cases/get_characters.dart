import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/core/resources/data_state.dart';
import 'package:rick_morty_api/core/use_case/use_case.dart';
import 'package:rick_morty_api/feature/character/data/models/character_model.dart';
import 'package:rick_morty_api/feature/character/data/repository/character_repository.dart';
import 'package:rick_morty_api/feature/character/domain/repository/icharacter_repository.dart';

final getCharacterProvider = Provider<GetCharacters>((ref) {
  ICharacterRepository characterRepository =
      ref.watch(characterRepositorProvider);
  return GetCharacters(characterRepository);
});

class GetCharacters
    implements UseCase<DataState<List<CharacterModel>>, GetCharactersParams> {
  final ICharacterRepository _characterRepository;

  GetCharacters(this._characterRepository);
  @override
  Future<DataState<List<CharacterModel>>> call(
      {required GetCharactersParams params}) async {
    try {
      final response = await _characterRepository.getCharacters();
      if (response.data?.results != null) {
        List<CharacterModel> characterList = response.data!.results!;

        return DataSuccess(characterList);
      } else {
        return DataFailed(
          Failure(message: 'characters is null'),
        );
      }
    } catch (e) {
      return DataFailed(
        Failure(
          message: e.toString(),
        ),
      );
    }
  }
}

class GetCharactersParams {
  final int page;
  final Map<String, String>? options;

  GetCharactersParams(this.page, this.options);
}
