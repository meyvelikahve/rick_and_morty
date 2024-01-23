import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/common/extention/http_response_error.dart';
import 'package:rick_morty_api/feature/episode/data/api/episode_api_service.dart';
import 'package:rick_morty_api/feature/episode/data/api/iepisode_api_service.dart';
import 'package:rick_morty_api/feature/episode/data/dto/episode_result.dart';
import 'package:rick_morty_api/feature/episode/domain/repository/iepisode_repository.dart';

final episodeRepositoryProvider = Provider<EpisodeRepository>((ref) {
  final episodeApiService = ref.watch(episodeApiServiceProvider);
  return EpisodeRepository(episodeApiService);
});

class EpisodeRepository implements IEpisodeRepository {
  final IEpisodeApiService _episodeApiService;
  EpisodeRepository(this._episodeApiService);

  @override
  Future<EpisodeResponse> getEpisodeResult(int? pageIndex) async {
    try {
      final response = await _episodeApiService.getEpisodeResult(pageIndex);

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
}
