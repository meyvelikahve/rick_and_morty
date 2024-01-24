import 'package:http/http.dart' as http;

abstract class ICharacterApiService {
  Future<http.Response> getCharacterResponse();
  Future<http.Response> getCharacterWithId(int id);
  Future<http.Response> getCharacterWithUrl(String url);
}
