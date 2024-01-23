import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/episode/application/iepisode_service.dart';
import 'package:rick_morty_api/feature/episode/data/dto/episode_result.dart';
import 'package:rick_morty_api/feature/episode/domain/model/episode.dart';
import 'package:rick_morty_api/feature/episode/domain/repository/episode_repository.dart';
import 'package:rick_morty_api/feature/episode/domain/repository/iepisode_repository.dart';

final episodeServiceProvider = Provider<EpisodeService>((ref) {
  final episodeRepository = ref.watch(episodeRepositoryProvider);
  return EpisodeService(episodeRepository);
});

class EpisodeService implements IEpisodeService {
  final IEpisodeRepository _episodeRepository;
  EpisodeService(
    this._episodeRepository,
  );

  @override
  Future<List<Episode>> getEpisodeList(int? pageIndex) async {
    try {
      final response = await _episodeRepository.getEpisodeResult(pageIndex);
      return episodeList(response);
    } catch (e) {
      rethrow;
    }
  }

  List<Episode> episodeList(EpisodeResponse episodeResult) {
    List<Episode> episodeList = [];
    final episodeResults = episodeResult.results;

    for (var episode in episodeResults) {
      Episode newEpisode = Episode(
          id: episode.id,
          name: episode.name,
          airDate: episode.airDate,
          episode: episode.episode,
          characters: episode.characters,
          url: episode.url,
          created: episode.created);
      episodeList.add(newEpisode);
    }

    return episodeList;
  }
}
