import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/common/mixin/url_mixin.dart';
import 'package:rick_morty_api/feature/character/data/data_sources/api/icharacter_api_service.dart';
import 'package:rick_morty_api/feature/character/data/models/character_model.dart';

final characterApiServiceProvider = Provider<ICharacterApiService>((ref) {
  return CharacterApiService();
});

class CharacterApiService with UrlMixin implements ICharacterApiService {
  String basePath = '/api/character';
  @override
  Future<List<CharacterDto>> getAllCharacters({int? page = 1}) async {
    try {
      final url = getUriWithPath(
        basePath,
        'page=$page',
      );

      var response = await http.get(url);

      var json = jsonDecode(response.body);

      final l = (json['results'] as List)
          .map((e) => CharacterDto.fromJson(e))
          .toList();
      return l;
    } on HttpException catch (e) {
      throw Failure(message: e.message, exception: e);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<CharacterDto> getCharacterDetail(int id) async {
    try {
      final url = getUriWithPath('$basePath/$id');

      var response = await http.get(url);

      var json = jsonDecode(response.body);

      return CharacterDto.fromJson(json);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
