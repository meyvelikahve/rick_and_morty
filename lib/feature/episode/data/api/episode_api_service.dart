import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/common/mixin/url_mixin.dart';
import 'package:rick_morty_api/feature/episode/data/api/iepisode_api_service.dart';
import 'package:http/http.dart' as http;

final episodeApiServiceProvider = Provider<EpisodeApiService>((ref) {
  return EpisodeApiService();
});

class EpisodeApiService with UrlMixin implements IEpisodeApiService {
  @override
  Future<http.Response> getEpisodeResult(int? pageIndex) async {
    try {
      final url = getUri('/api/episode', "page=$pageIndex");

      return await http.get(url);
    } catch (e) {
      rethrow;
    }
  }
}
