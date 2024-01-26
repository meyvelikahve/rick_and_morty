import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/core/resources/data_state.dart';
import 'package:rick_morty_api/core/use_case/use_case.dart';
import 'package:rick_morty_api/feature/character/data/models/character_model.dart';
import 'package:rick_morty_api/feature/character/data/models/character_model_extention.dart';
import 'package:rick_morty_api/feature/character/data/repository/character_repository_impl.dart';
import 'package:rick_morty_api/feature/character/domain/repository/character_repository.dart';
import '../entities/character_entity.dart';

final getCharacterProvider = Provider<GetCharacters>((ref) {
  CharacterRepository characterRepository =
      ref.read(characterRepositorProvider);
  return GetCharacters(characterRepository);
});

class GetCharacters implements UseCase<List<CharacterEntity>, int> {
  final CharacterRepository _characterRepository;

  GetCharacters(this._characterRepository);
  @override
  Future<List<CharacterEntity>> call({int? params}) async {
    try {
      List<CharacterEntity> entityList =
          await _characterRepository.getAllCharacters(page: params);

      return entityList;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }
}
