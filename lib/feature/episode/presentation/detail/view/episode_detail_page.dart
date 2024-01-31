import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/episode/domain/entities/episode.dart';
import 'package:rick_morty_api/feature/episode/presentation/detail/view/widget/episode_character_list_widget.dart';

class EpisodeDetailPage extends StatelessWidget {
  final EpisodeEntity episodeEntity;
  const EpisodeDetailPage({super.key, required this.episodeEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight,
        title: const Text('Episode Detail'),
      ),
      body: _Content(
        episodeEntity: episodeEntity,
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content({super.key, required this.episodeEntity});
  final EpisodeEntity episodeEntity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      child: Column(
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
                    episodeEntity.episode,
                    style: textTheme.displaySmall!.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Divider(),
                  Text(
                    episodeEntity.name,
                    style: textTheme.displaySmall!.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Air Date: ${episodeEntity.airDate}',
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  Text(
                    'Type: ${episodeEntity.name}',
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
              'Characters:',
              style: textTheme.bodyLarge!.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(
              height: 150,
              width: 150,
              child: EpisodeChacterListItem(
                episodeEntity: episodeEntity,
              ))
        ],
      ),
    );
  }
}
