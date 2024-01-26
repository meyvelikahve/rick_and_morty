import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/episode/domain/entities/episode.dart';
import 'package:rick_morty_api/feature/episode/domain/use_cases/get_all_episodes.dart';
import 'package:rick_morty_api/feature/episode/presentation/state/page_index_provider.dart';
import 'package:rick_morty_api/utils/api_future_builder.dart';

class EpisodeScreen extends ConsumerStatefulWidget {
  const EpisodeScreen({super.key});

  @override
  ConsumerState<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends ConsumerState<EpisodeScreen> {
  String? url;
  @override
  Widget build(BuildContext context) {
    var getAllEpisodes = ref.watch(getAllEpisodesProvider);
    return Scaffold(
      body: GeneralFutureBuilder(
        future: getAllEpisodes.call(params: 0),
        builder: (context, data) {
          List<EpisodeEntity> episodeEntityList = data;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: episodeEntityList.length,
                  itemBuilder: (context, index) {
                    var episode = episodeEntityList[index];
                    return Card(
                      child: ListTile(
                        trailing: Text(episode.episode),
                        title: Text(episode.name),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget bodyColumn(WidgetRef ref, List<EpisodeEntity> episodeEntityList) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: episodeEntityList.length,
            itemBuilder: (context, index) {
              EpisodeEntity episode = episodeEntityList[index];
              return ListTile(
                title: Text(episode.name),
              );
            },
          ),
        ),
        IconButton(
          onPressed: () {
            ref.read(pageIndexProvider.notifier).nextIndex();
          },
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
