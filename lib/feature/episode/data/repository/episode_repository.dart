import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/common/extention/http_response_error.dart';
import 'package:rick_morty_api/feature/episode/data/api/episode_api_service.dart';
import 'package:rick_morty_api/feature/episode/data/api/iepisode_api_service.dart';
import 'package:rick_morty_api/feature/episode/data/dto/episode_response.dart';
import 'package:rick_morty_api/feature/episode/data/repository/iepisode_repository.dart';

final episodeRepositoryProvider = Provider<EpisodeRepository>((ref) {
  final episodeApiService = ref.watch(episodeApiServiceProvider);
  return EpisodeRepository(episodeApiService);
});

class EpisodeRepository implements IEpisodeRepository {
  final IEpisodeApiService _episodeApiService;
  EpisodeRepository(this._episodeApiService);

  @override
  Future<EpisodeResponse> getEpisodeResponse({String? url}) async {
    try {
      final response = await _episodeApiService.getEpisodeResponse(url: url);

      if (response.statusCode != HttpStatus.ok) {
        // from extention: httpResponseError
        throw Failure(
          message: response.httpResponseError(),
        );
      }
      var json = jsonDecode(response.body);
      return EpisodeResponse.fromJson(json);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<EpisodeResult> getEpisodeWithId(int id) async {
    try {
      final response = await _episodeApiService.getEpisodeWithId(id);

      if (response.statusCode != HttpStatus.ok) {
        // from extention: httpResponseError
        throw Failure(
          message: response.httpResponseError(),
        );
      }
      var json = jsonDecode(response.body);
      return EpisodeResult.fromJson(json);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<EpisodeResult> getEpisodeWithUrl(String url) async {
    try {
      final response = await _episodeApiService.getEpisodeWithUrl(url);

      if (response.statusCode != HttpStatus.ok) {
        // from extention: httpResponseError
        throw Failure(
          message: response.httpResponseError(),
        );
      }
      var json = jsonDecode(response.body);
      print(json);
      return EpisodeResult.fromJson(json['results']);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
