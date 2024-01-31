import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/character/domain/use_cases/get_charactecter_detail.dart';
import 'package:rick_morty_api/feature/episode/domain/entities/episode.dart';
import 'package:rick_morty_api/feature/shared_widgets/item_image_widget.dart';
import 'package:rick_morty_api/utils/api_future_builder.dart';

class EpisodeChacterListItem extends ConsumerWidget {
  const EpisodeChacterListItem({super.key, required this.episodeEntity});
  final EpisodeEntity episodeEntity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetCharacterDetail getCharacterDetail =
        ref.watch(getCharacterDetailProvider);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: episodeEntity.characters.length,
      itemBuilder: (context, index) {
        final characters = episodeEntity.characters;
        final characterId = characters[index].split('/').last;

        return GeneralFutureBuilder(
          future: getCharacterDetail.call(params: int.tryParse(characterId)),
          placeHolder: Container(
            height: 150,
          ),
          builder: (context, data) {
            return InkWell(
              onTap: () {
                // context.goNamed(RoutePathEnum.locationCharacterDetail.name,
                //     pathParameters: {
                //       'locationId': location.id.toString(),
                //       'characterId': characterId
                //     },
                //     extra: data);
              },
              child: ImageCardWidget(
                  name: data?.name ?? '', imageUrl: data?.image ?? ''),
            );
          },
        );
      },
    );
  }
}
