import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/location/domain/entities/location_entity.dart';
import 'package:rick_morty_api/feature/location/presentation/detail/view/widget/residents_list_widget.dart';

class LocationDetailPage extends StatelessWidget {
  final String? locationId;
  final LocationEntity locationEntity;

  const LocationDetailPage(
      {super.key, this.locationId, required this.locationEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight,
        title: const Text('Location Detail'),
      ),
      body: _Content(locationEntity: locationEntity),
    );
  }
}

class _Content extends ConsumerWidget {
  final String? locationId;
  final LocationEntity locationEntity;
  const _Content({super.key, this.locationId, required this.locationEntity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    LocationEntity location = locationEntity;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  location.name,
                  style: textTheme.displaySmall!.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Dimension: ${location.dimension}',
                ),
                const SizedBox(height: 8),
                const Divider(height: 1),
                const SizedBox(height: 16),
                Text(
                  'Type: ${location.type}',
                  style: textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Residents: ${location.residents.length}',
            style: textTheme.bodyLarge!.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: ResidentListWidget(
            location: location,
          ),
        )
      ],
    );
  }
}
