import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/core/use_case/use_case.dart';
import 'package:rick_morty_api/feature/episode/data/repository/episode_repository_impl.dart';
import 'package:rick_morty_api/feature/episode/domain/entities/episode.dart';
import 'package:rick_morty_api/feature/episode/domain/repository/episode_repository.dart';

final getAllEpisodesProvider = Provider<GetAllEpisodes>((ref) {
  EpisodeRepository episodeRepository = ref.read(episodeRepositoryProvider);
  return GetAllEpisodes(episodeRepository);
});

class GetAllEpisodes extends UseCase<List<EpisodeEntity>, int> {
  final EpisodeRepository _episodeRepository;

  GetAllEpisodes(this._episodeRepository);
  @override
  Future<List<EpisodeEntity>> call({int? params}) async {
    List<EpisodeEntity> episodes =
        await _episodeRepository.getAllEpisodes(page: params);
    return episodes;
  }
}
