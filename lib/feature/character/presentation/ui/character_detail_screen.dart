import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/character/application/character_service.dart';
import 'package:rick_morty_api/feature/character/application/icharacter_service.dart';
import 'package:rick_morty_api/utils/api_future_builder.dart';

import '../../domain/model/character.dart';

class CharacterDetailScreen extends ConsumerWidget {
  final int id;
  const CharacterDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ICharacterService characterService = ref.watch(characterServiceProvider);
    return GeneralFutureBuilder(
      future: characterService.getCharacterWithId(id),
      builder: (context, data) {
        return myBody(data);
      },
    );
  }

  Widget myBody(Character character) {
    return Column(
      children: [
        Image.network(character.image),
        Text(character.name),
      ],
    );
  }
}
