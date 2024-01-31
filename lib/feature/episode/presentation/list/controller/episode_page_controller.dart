import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/episode/domain/use_cases/get_all_episodes.dart';
import 'package:rick_morty_api/feature/episode/presentation/list/controller/episode_page_state.dart';

final episodePageStateProvider =
    StateNotifierProvider<EpisodePageController, EpisodePageState>(
  (ref) => EpisodePageController(
    getAllEpisodes: ref.read(getAllEpisodesProvider),
  ),
);

class EpisodePageController extends StateNotifier<EpisodePageState> {
  EpisodePageController({
    required GetAllEpisodes getAllEpisodes,
  })  : _getAllCharacters = getAllEpisodes,
        super(const EpisodePageState());

  final GetAllEpisodes _getAllCharacters;

  Future<void> fetchNextPage() async {
    if (state.hasReachedEnd) return;

    state = state.copyWith(status: EpisodePageStatus.loading);

    final list = await _getAllCharacters.call(params: state.currentPage);

    if (list != null) {
      state = state.copyWith(
        status: EpisodePageStatus.loading,
        currentPage: state.currentPage + 1,
        episodes: List.of(state.episodes)..addAll(list),
        hasReachedEnd: list.isEmpty,
      );
    }
  }
}
