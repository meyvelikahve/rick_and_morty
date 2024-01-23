import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/episode/application/episode_service.dart';
import 'package:rick_morty_api/feature/episode/domain/model/episode.dart';
import 'package:rick_morty_api/feature/episode/presentation/state/page_index_provider.dart';
import 'package:rick_morty_api/utils/api_future_builder.dart';

class EpisodeScreen extends ConsumerWidget {
  const EpisodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    EpisodeService episodeService = ref.watch(episodeServiceProvider);
    int pageIndex = ref.watch(pageIndexProvider);
    return Scaffold(
      body: GeneralFutureBuilder(
        future: episodeService.getEpisodeList(pageIndex),
        builder: (context, data) {
          return bodyColumn(ref, data);
        },
      ),
    );
  }

  Widget bodyColumn(WidgetRef ref, List<Episode> episodeList) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: episodeList.length,
            itemBuilder: (context, index) {
              Episode episode = episodeList[index];
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
