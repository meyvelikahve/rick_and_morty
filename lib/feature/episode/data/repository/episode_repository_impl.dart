import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/feature/episode/data/api/episode_api_service.dart';
import 'package:rick_morty_api/feature/episode/data/api/iepisode_api_service.dart';
import 'package:rick_morty_api/feature/episode/data/dto/episode_dto_extention.dart';
import 'package:rick_morty_api/feature/episode/domain/entities/episode.dart';
import 'package:rick_morty_api/feature/episode/domain/repository/episode_repository.dart';

final episodeRepositoryProvider = Provider<EpisodeRepository>((ref) {
  final episodeApiService = ref.watch(episodeApiServiceProvider);
  return EpisodeRepositoryImpl(episodeApiService);
});

class EpisodeRepositoryImpl implements EpisodeRepository {
  final IEpisodeApiService _episodeApiService;
  EpisodeRepositoryImpl(this._episodeApiService);

  @override
  Future<List<EpisodeEntity>> getAllEpisodes({int? page}) async {
    try {
      List<EpisodeEntity> episodeList = [];
      final episodeDtoList =
          await _episodeApiService.getAllEpisodes(page: page);
      for (var episodeDto in episodeDtoList) {
        episodeList.add(episodeDto.toEpisodeEntity());
      }
      return episodeList;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<EpisodeEntity> getEpisodeWithId(int id) async {
    try {
      final episodeDto = await _episodeApiService.getEpisodeWithId(id);

      return episodeDto.toEpisodeEntity();
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
