import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/episode/application/iepisode_service.dart';
import 'package:rick_morty_api/feature/episode/data/dto/episode_response.dart';
import 'package:rick_morty_api/feature/episode/domain/model/episode.dart';
import 'package:rick_morty_api/feature/episode/data/repository/episode_repository.dart';
import 'package:rick_morty_api/feature/episode/data/repository/iepisode_repository.dart';

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
  Future<EpisodeResponse> getEpisodeResponse({String? url}) async {
    try {
      final response = await _episodeRepository.getEpisodeResponse(url: url);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Episode> getEpisodeWithId(int id) async {
    final response = await _episodeRepository.getEpisodeWithId(id);
    return resultToEpisode(response);
  }

  @override
  Future<Episode> getEpisodeWithUrl(String url) async {
    final response = await _episodeRepository.getEpisodeWithUrl(url);
    return resultToEpisode(response);
  }

  Episode resultToEpisode(EpisodeResult result) {
    Episode newEpisode = Episode(
        id: result.id,
        name: result.name,
        airDate: result.airDate,
        episode: result.episode,
        characters: result.characters,
        url: result.url,
        created: result.created);
    return newEpisode;
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
