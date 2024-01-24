import 'package:http/http.dart' as http;

abstract class IEpisodeApiService {
  Future<http.Response> getEpisodeResponse({String? url});
  Future<http.Response> getEpisodeWithId(int id);
  Future<http.Response> getEpisodeWithUrl(String url);
}
