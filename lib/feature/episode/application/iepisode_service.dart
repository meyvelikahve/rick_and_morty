import 'package:rick_morty_api/feature/episode/data/dto/episode_response.dart';
import 'package:rick_morty_api/feature/episode/domain/model/episode.dart';

abstract class IEpisodeService {
  Future<EpisodeResponse> getEpisodeResponse({String? url});
  Future<Episode> getEpisodeWithId(int id);
  Future<Episode> getEpisodeWithUrl(String url);
}
