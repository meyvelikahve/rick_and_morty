import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/common/mixin/url_mixin.dart';
import 'package:rick_morty_api/feature/character/data/api/icharacter_api_service.dart';

final characterApiServiceProvider = Provider<ICharacterApiService>((ref) {
  return CharacterApiService();
});

class CharacterApiService with UrlMixin implements ICharacterApiService {
  String basePath = '/api/character';
  @override
  Future<http.Response> getCharacterResponse() async {
    try {
      final url = getUriWithPath(basePath);

      return await http.get(url);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<http.Response> getCharacterWithId(int id) async {
    try {
      final url = getUriWithPath('$basePath/$id');

      return await http.get(url);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<http.Response> getCharacterWithUrl(String url) async {
    try {
      return await http.get(getUri(url));
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
