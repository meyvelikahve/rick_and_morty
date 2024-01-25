import 'package:http/http.dart' as http;

abstract class ICharacterApiService {
  Future<http.Response> getCharacters();
  Future<http.Response> getCharacterDetail(int id);
  // Future<http.Response> getCharacterWithId(int id);
  // Future<http.Response> getCharacterWithUrl(String url);
}
