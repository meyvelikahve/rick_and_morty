import 'package:http/http.dart' as http;

abstract class IEpisodeApiService {
  Future<http.Response> getEpisodeResult(int? pageIndex);
}
