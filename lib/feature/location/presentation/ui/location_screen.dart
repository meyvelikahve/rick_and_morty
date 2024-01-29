import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/location/domain/entities/location_entity.dart';
import 'package:rick_morty_api/feature/location/domain/use_case/get_all_locations.dart';
import 'package:rick_morty_api/utils/api_future_builder.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var locationService = ref.watch(getAllLocationProvider);
    return GeneralFutureBuilder(
      future: locationService.call(),
      builder: (context, data) {
        return myListView(data);
      },
    );
  }

  Widget myListView(List<LocationEntity>? data) {
    return ListView.builder(
      itemCount: data?.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(data?[index].name ?? ''),
        );
      },
    );
  }
}
