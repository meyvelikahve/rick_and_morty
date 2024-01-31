import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/location/domain/use_case/get_all_locations.dart';
import 'package:rick_morty_api/feature/location/presentation/list/controller/location_page_state.dart';

final locationPageStateProvider =
    StateNotifierProvider<LocationStateNotifier, LocationPageState>(
  (ref) => LocationStateNotifier(
    getAllLocations: ref.read(getAllLocationProvider),
  ),
);

class LocationStateNotifier extends StateNotifier<LocationPageState> {
  LocationStateNotifier({
    required GetAllLocations getAllLocations,
  })  : _getAllLocations = getAllLocations,
        super(const LocationPageState());

  final GetAllLocations _getAllLocations;

  Future<void> fetchNextPage() async {
    if (state.hasReachedEnd) return;

    state = state.copyWith(status: LocationPageStatus.loading);

    final list = await _getAllLocations.call(params: state.currentPage);

    if (list != null) {
      state = state.copyWith(
        status: LocationPageStatus.loading,
        currentPage: state.currentPage + 1,
        locations: List.of(state.locations)..addAll(list),
        hasReachedEnd: list.isEmpty,
      );
    }
  }
}
