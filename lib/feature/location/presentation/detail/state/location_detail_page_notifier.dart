import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/location/domain/entities/location_entity.dart';
import 'package:rick_morty_api/feature/location/presentation/detail/state/location_detail_state.dart';

final locationDetailPageProvider =
    NotifierProvider<LocationDetailPageNotifier, LocationDetailPageState>(
  () => LocationDetailPageNotifier(),
);

class LocationDetailPageNotifier extends Notifier<LocationDetailPageState> {
  LocationDetailPageNotifier();

  @override
  LocationDetailPageState build() => LocationDetailPageState();

  setLocation(LocationEntity locationEntity) {
    state.location = locationEntity;
  }
}
