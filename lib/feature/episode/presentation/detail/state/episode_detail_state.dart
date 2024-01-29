import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/episode/domain/entities/episode.dart';
import 'package:rick_morty_api/feature/episode/presentation/detail/state/episode_detail_page_state.dart';

final episodeDetailsPageProvider =
    NotifierProvider<EpisodeDetailsPageNotifier, EpisodeDetailPageState>(
        EpisodeDetailsPageNotifier.new);

class EpisodeDetailsPageNotifier extends Notifier<EpisodeDetailPageState> {
  EpisodeDetailsPageNotifier();
  @override
  EpisodeDetailPageState build() => EpisodeDetailPageState();

  setEpisode(EpisodeEntity episodeEntity) {
    state.entity = episodeEntity;
  }
}
