import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/common/mixin/url_mixin.dart';
import 'package:rick_morty_api/feature/episode/data/api/iepisode_api_service.dart';
import 'package:http/http.dart' as http;

final episodeApiServiceProvider = Provider<EpisodeApiService>((ref) {
  return EpisodeApiService();
});

class EpisodeApiService with UrlMixin implements IEpisodeApiService {
  String basePath = '/api/episode';
  @override
  Future<http.Response> getEpisodeResponse({String? url}) async {
    try {
      if (url != null) {
        return http.get(getUri(url));
      }
      final uri = getUriWithPath(basePath);

      return await http.get(uri);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<http.Response> getEpisodeWithId(int id) async {
    try {
      final url = getUriWithPath('$basePath/$id');

      return await http.get(url);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<http.Response> getEpisodeWithUrl(String url) async {
    try {
      return await http.get(getUri(url));
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
