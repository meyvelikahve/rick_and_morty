import 'package:rick_morty_api/feature/episode/data/dto/episode_dto.dart';

abstract class IEpisodeApiService {
  Future<List<EpisodeDto>?> getAllEpisodes({int? page});
  Future<EpisodeDto> getEpisodeWithId(int id);
}
