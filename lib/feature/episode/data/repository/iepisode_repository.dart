import 'package:rick_morty_api/feature/episode/data/dto/episode_response.dart';

abstract class IEpisodeRepository {
  Future<EpisodeResponse> getEpisodeResponse({String? url});
  Future<EpisodeResult> getEpisodeWithId(int id);
  Future<EpisodeResult> getEpisodeWithUrl(String url);
}
