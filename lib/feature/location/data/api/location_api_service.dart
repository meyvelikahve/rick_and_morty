import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/common/mixin/url_mixin.dart';
import 'package:rick_morty_api/feature/location/data/api/ilocation_api_service.dart';
import 'package:rick_morty_api/feature/location/data/dto/location_dto.dart';

final locationApiServiceProvider = Provider<ILocationApiService>((ref) {
  return LocationApiService();
});

class LocationApiService with UrlMixin implements ILocationApiService {
  @override
  Future<List<LocationDto>> getAllLocations({int? page}) async {
    try {
      List<LocationDto> locations = [];
      Uri url = getUriWithPath('/api/location', 'page=$page');

      var response = await http.get(url);

      if (response.statusCode == HttpStatus.ok) {
        var json = jsonDecode(response.body);
        for (var location in json['results']) {
          locations.add(LocationDto.fromJson(location));
        }
      }
      return locations;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
