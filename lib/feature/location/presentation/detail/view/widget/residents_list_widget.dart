import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/app/navigation/app_navigation.dart';
import 'package:rick_morty_api/feature/character/domain/use_cases/get_charactecter_detail.dart';
import 'package:rick_morty_api/feature/character/presentation/list/view/widget/list_item.dart';
import 'package:rick_morty_api/feature/location/domain/entities/location_entity.dart';
import 'package:rick_morty_api/feature/shared_widgets/item_image_widget.dart';
import 'package:rick_morty_api/utils/api_future_builder.dart';

class ResidentListWidget extends ConsumerWidget {
  const ResidentListWidget({super.key, required this.location});
  final LocationEntity location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = MediaQuery.of(context).size;

    GetCharacterDetail getCharacterDetail =
        ref.watch(getCharacterDetailProvider);

    return ListView.builder(
      itemCount: location.residents.length,
      itemBuilder: (context, index) {
        final residents = location.residents;
        final characterId = residents[index].split('/').last;

        return GeneralFutureBuilder(
          future: getCharacterDetail.call(params: int.tryParse(characterId)),
          placeHolder: Container(),
          builder: (context, data) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CharacterListItem(
                item: data!,
                onTap: (character) {
                  // _goToDetailsPage(context, ref, character);
                },
              ),
            );
          },
        );
      },
    );
  }
}
