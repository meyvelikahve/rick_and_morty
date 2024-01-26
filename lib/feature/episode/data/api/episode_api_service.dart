import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/common/mixin/url_mixin.dart';
import 'package:rick_morty_api/feature/episode/data/api/iepisode_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:rick_morty_api/feature/episode/data/dto/episode_dto.dart';

final episodeApiServiceProvider = Provider<EpisodeApiService>((ref) {
  return EpisodeApiService();
});

class EpisodeApiService with UrlMixin implements IEpisodeApiService {
  String basePath = '/api/episode';
  @override
  Future<List<EpisodeDto>> getAllEpisodes({int? page}) async {
    try {
      final url = getUriWithPath(
        basePath,
        'page=$page',
      );

      var response = await http.get(url);

      var json = jsonDecode(response.body);

      final l =
          (json['results'] as List).map((e) => EpisodeDto.fromJson(e)).toList();
      return l;
    } on HttpException catch (e) {
      throw Failure(message: e.message, exception: e);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<EpisodeDto> getEpisodeWithId(int id) async {
    try {
      final url = getUriWithPath('$basePath/$id');
      var response = await http.get(url);
      var json = jsonDecode(response.body);

      return EpisodeDto.fromJson(json);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
