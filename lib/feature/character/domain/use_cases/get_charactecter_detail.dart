import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/core/resources/data_state.dart';
import 'package:rick_morty_api/core/use_case/use_case.dart';
import 'package:rick_morty_api/feature/character/data/models/character_model.dart';
import 'package:rick_morty_api/feature/character/data/repository/character_repository.dart';
import 'package:rick_morty_api/feature/character/domain/repository/icharacter_repository.dart';

final getCharacterDetailProvider = Provider<GetCharacterDetail>((ref) {
  ICharacterRepository characterRepository =
      ref.watch(characterRepositorProvider);
  return GetCharacterDetail(characterRepository);
});

class GetCharacterDetail implements UseCase<DataState<CharacterModel>, int> {
  final ICharacterRepository _characterRepository;
  GetCharacterDetail(this._characterRepository);

  @override
  Future<DataState<CharacterModel>> call({required int params}) async {
    try {
      var response = await _characterRepository.getCharacterDetail(params);

      if (response.data != null) {
        return DataSuccess(response.data!);
      } else {
        return DataFailed(Failure(message: 'character not found'));
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
