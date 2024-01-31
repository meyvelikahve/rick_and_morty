import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/character/domain/use_cases/get_characters.dart';
import 'package:rick_morty_api/feature/character/presentation/list/controller/character_page_state.dart';

final characterPageControllerProvider =
    StateNotifierProvider<CharacterPageController, CharacterPageState>(
  (ref) => CharacterPageController(
    getAllCharacters: ref.read(getCharacterProvider),
  ),
);

class CharacterPageController extends StateNotifier<CharacterPageState> {
  CharacterPageController({
    required GetCharacters getAllCharacters,
  })  : _getAllCharacters = getAllCharacters,
        super(const CharacterPageState());

  final GetCharacters _getAllCharacters;

  Future<void> fetchNextPage() async {
    if (state.hasReachedEnd) return;

    state = state.copyWith(status: CharacterPageStatus.loading);

    final list = await _getAllCharacters.call(params: state.currentPage);

    state = state.copyWith(
      status: CharacterPageStatus.loading,
      currentPage: state.currentPage + 1,
      characters: List.of(state.characters)..addAll(list),
      hasReachedEnd: list.isEmpty,
    );
  }
}
