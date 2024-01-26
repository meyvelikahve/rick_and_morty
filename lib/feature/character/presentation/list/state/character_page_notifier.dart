import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/character/domain/use_cases/get_characters.dart';
import 'package:rick_morty_api/feature/character/presentation/list/state/character_page_state.dart';

final characterPageStateProvider =
    StateNotifierProvider<CharacterStateNotifier, CharacterPageState>(
  (ref) => CharacterStateNotifier(
    getAllCharacters: ref.read(getCharacterProvider),
  ),
);

class CharacterStateNotifier extends StateNotifier<CharacterPageState> {
  CharacterStateNotifier({
    required GetCharacters getAllCharacters,
  })  : _getAllCharacters = getAllCharacters,
        super(const CharacterPageState());

  final GetCharacters _getAllCharacters;

  Future<void> fetchNextPage() async {
    if (state.hasReachedEnd) return;

    state = state.copyWith(status: CharacterPageStatus.loading);

    final list = await _getAllCharacters.call(params: state.currentPage);

    print(state.currentPage.toString());
    state = state.copyWith(
      status: CharacterPageStatus.loading,
      currentPage: state.currentPage + 1,
      characters: List.of(state.characters)..addAll(list),
      hasReachedEnd: list.isEmpty,
    );
  }
}
