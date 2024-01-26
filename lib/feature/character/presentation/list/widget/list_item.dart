import 'package:flutter/material.dart';
import 'package:rick_morty_api/feature/character/domain/entities/character_entity.dart';

typedef OnCharacterListItemTap = void Function(CharacterEntity character);

class CharacterListItem extends StatelessWidget {
  const CharacterListItem({
    super.key,
    required this.item,
    this.onTap,
  });

  final CharacterEntity item;
  final OnCharacterListItemTap? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(item),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: SizedBox(
          height: 124,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _ItemPhoto(item: item),
              _ItemDescription(item: item),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Helpers
// -----------------------------------------------------------------------------

class _ItemDescription extends StatelessWidget {
  const _ItemDescription({super.key, required this.item});

  final CharacterEntity item;

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
                  item.name ?? '',
                  style: textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Status: ${item.status}',
                  style: textTheme.labelSmall!.copyWith(),
                ),
                const SizedBox(height: 4),
                Text(
                  'Last location: ${item.location?.name ?? ''}',
                  style: textTheme.labelSmall!.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
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

  final CharacterEntity item;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: SizedBox(
        height: 122,
        child: Hero(
          tag: item.id!,
          child: Image.network(item.image!),
          // child: CachedNetworkImage(
          //   height: 122,
          //   width: 122,
          //   imageUrl: item.image!,
          //   fit: BoxFit.cover,
          //   errorWidget: (ctx, url, err) => const Icon(Icons.error),
          //   placeholder: (ctx, url) => const Icon(Icons.image),
          // ),
        ),
      ),
    );
  }
}
