import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/location/data/api/ilocation_api_service.dart';
import 'package:rick_morty_api/feature/location/data/api/location_api_service.dart';
import 'package:rick_morty_api/feature/location/data/dto/location_response.dart';
import 'package:rick_morty_api/feature/location/data/repository/ilocation_respository.dart';

final locationRepositoryProvider = Provider<ILocationRepository>((ref) {
  var locationApiService = ref.watch(locationApiServiceProvider);
  return LocationRepository(locationApiService);
});

class LocationRepository implements ILocationRepository {
  final ILocationApiService _locationApiService;
  LocationRepository(this._locationApiService);

  @override
  Future<LocationResponse> getLocationResponse() async {
    var response = await _locationApiService.getLocationResponse();

    var json = jsonDecode(response.body);

    return LocationResponse.fromJson(json);
  }
}
