import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/character/domain/entities/character_entity.dart';
import 'package:rick_morty_api/feature/character/presentation/detail/state/detail_page_state.dart';

final characterDetailsPageProvider =
    NotifierProvider<DetailsPageNotifier, DetailsPageState>(
  () => DetailsPageNotifier(),
);

class DetailsPageNotifier extends Notifier<DetailsPageState> {
  DetailsPageNotifier();

  @override
  DetailsPageState build() => DetailsPageState();

  setCharacter(CharacterEntity characterEntity) {
    state.character = characterEntity;
  }
}
