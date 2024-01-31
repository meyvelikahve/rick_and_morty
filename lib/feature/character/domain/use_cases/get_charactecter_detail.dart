import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/core/use_case/use_case.dart';
import 'package:rick_morty_api/feature/character/data/repository/character_repository_impl.dart';
import 'package:rick_morty_api/feature/character/domain/entities/character_entity.dart';
import 'package:rick_morty_api/feature/character/domain/repository/character_repository.dart';

final getCharacterDetailProvider = Provider<GetCharacterDetail>((ref) {
  CharacterRepository characterRepository =
      ref.watch(characterRepositorProvider);
  return GetCharacterDetail(characterRepository);
});

class GetCharacterDetail implements UseCase<CharacterEntity, int> {
  final CharacterRepository _characterRepository;
  GetCharacterDetail(this._characterRepository);

  @override
  Future<CharacterEntity?> call({int? params}) async {
    try {
      if (params == null) {
        return null;
      }
      CharacterEntity characterEntity =
          await _characterRepository.getCharacterDetail(params);

      return characterEntity;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }
}
