import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/core/use_case/use_case.dart';
import 'package:rick_morty_api/feature/episode/data/repository/episode_repository_impl.dart';
import 'package:rick_morty_api/feature/episode/domain/entities/episode.dart';
import 'package:rick_morty_api/feature/episode/domain/repository/episode_repository.dart';

final getEpisodeProvider = Provider<GetEpisodeDetail>((ref) {
  EpisodeRepository episodeRepository = ref.watch(episodeRepositoryProvider);
  return GetEpisodeDetail(episodeRepository);
});

class GetEpisodeDetail extends UseCase<EpisodeEntity, int> {
  final EpisodeRepository _episodeRepository;

  GetEpisodeDetail(this._episodeRepository);
  @override
  Future<EpisodeEntity> call({int? params}) async {
    EpisodeEntity episode =
        await _episodeRepository.getEpisodeWithId(params ?? 1);
    return episode;
  }
}
