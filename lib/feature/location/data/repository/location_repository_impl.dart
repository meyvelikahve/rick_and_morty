import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/common/exception/failure.dart';
import 'package:rick_morty_api/feature/location/data/api/ilocation_api_service.dart';
import 'package:rick_morty_api/feature/location/data/api/location_api_service.dart';
import 'package:rick_morty_api/feature/location/data/dto/location_dto.dart';
import 'package:rick_morty_api/feature/location/data/dto/location_dto_extention.dart';
import 'package:rick_morty_api/feature/location/domain/entities/location_entity.dart';
import 'package:rick_morty_api/feature/location/domain/repository/location_repository.dart';

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  var locationApiService = ref.watch(locationApiServiceProvider);
  return LocationRepositoryImpl(locationApiService);
});

class LocationRepositoryImpl implements LocationRepository {
  final ILocationApiService _locationApiService;
  LocationRepositoryImpl(this._locationApiService);

  @override
  Future<List<LocationEntity>> getAllLocations({int? page}) async {
    try {
      List<LocationEntity> locationEntityList = [];
      List<LocationDto> locationDtoList =
          await _locationApiService.getAllLocations(page: page);

      for (var locationDto in locationDtoList) {
        locationEntityList.add(locationDto.toLocationEntity());
      }
      return locationEntityList;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
