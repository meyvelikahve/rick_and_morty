import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/location/presentation/detail/state/location_detail_page_notifier.dart';

class LocationDetailPage extends StatelessWidget {
  const LocationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight,
        title: const Text('Details'),
      ),
      body: const _Content(),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final location = ref.watch(locationDetailPageProvider).location!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: location.id,
            child: Text(location.name),
            //child: Image.network(location. ?? ''),
          ),
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
                  Text(
                    'Last location: ${location.residents.length}',
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
              'Episodes:',
              style: textTheme.bodyLarge!.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: location.residents.length,
              itemBuilder: (context, index) {
                final residents = location.residents;
                //final name = residents.split('/').last;

                return Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 8),
                  child: InkWell(
                    onTap: () {
                      print("object ${residents[index]}");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                        color: colorScheme.surfaceVariant,
                      ),
                      height: 80,
                      width: 80,
                      child: Center(
                        child: Text(
                          residents[index].characters.first,
                          style: textTheme.bodyLarge!.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
