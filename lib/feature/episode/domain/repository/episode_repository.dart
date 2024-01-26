import 'package:rick_morty_api/feature/episode/domain/entities/episode.dart';

abstract class EpisodeRepository {
  Future<List<EpisodeEntity>> getAllEpisodes({int? page});
  Future<EpisodeEntity> getEpisodeWithId(int id);
}
