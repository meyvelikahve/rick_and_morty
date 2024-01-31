import 'package:flutter/material.dart';
import 'package:rick_morty_api/feature/location/domain/entities/location_entity.dart';

typedef OnLocationListItemTap = void Function(LocationEntity entity);

class LocationListItem extends StatelessWidget {
  const LocationListItem({
    super.key,
    required this.item,
    this.onTap,
  });

  final LocationEntity item;
  final OnLocationListItemTap? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(item),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // _ItemPhoto(item: item),
              _ItemDescription(item: item),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemDescription extends StatelessWidget {
  const _ItemDescription({super.key, required this.item});

  final LocationEntity item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            color: colorScheme.surfaceVariant,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  item.name,
                  style: textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Dimention: ${item.dimension}',
                  style: textTheme.labelSmall!.copyWith(),
                ),
                const SizedBox(height: 4),
                Text(
                  'Type: ${item.type}',
                  style: textTheme.labelSmall!.copyWith(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemPhoto extends StatelessWidget {
  const _ItemPhoto({super.key, required this.item});

  final LocationEntity item;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Container(
        height: 122,
        width: 122,
        color: Theme.of(context).hoverColor,
        child: Card(
          child: Image.asset(
            'assets/images/rick_and_morty_location.jpg',
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
