import 'package:rick_morty_api/feature/episode/data/dto/episode_result.dart';

abstract class IEpisodeRepository {
  Future<EpisodeResponse> getEpisodeResult(int? pageIndex);
}
