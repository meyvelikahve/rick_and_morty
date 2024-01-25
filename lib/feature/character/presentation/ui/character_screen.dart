import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/core/navigation/app_navigation.dart';
import 'package:rick_morty_api/feature/character/data/models/character_model.dart';
import 'package:rick_morty_api/feature/character/domain/use_cases/get_characters.dart';

class CharacterScreen extends ConsumerWidget {
  const CharacterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetCharacters getCharacters = ref.watch(getCharacterProvider);
    return Scaffold(
      body: FutureBuilder(
        future: getCharacters.call(params: GetCharactersParams(1, {})),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data?.data != null) {
              return bodyColumn(ref, snapshot.data!.data!);
            } else {
              return const Center(
                child: Text("Episodes not found."),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }

  Widget bodyColumn(WidgetRef ref, List<CharacterModel> characterList) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            itemCount: characterList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, mainAxisExtent: 100),
            itemBuilder: (context, index) {
              CharacterModel character = characterList[index];

              return InkWell(
                onTap: () {
                  click(context, characterList, index);
                },
                child: Card(
                  child: Row(
                    children: [
                      Expanded(child: Image.network(character.image!)),
                      Expanded(
                        child: Center(
                          child: Text(character.species!),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        IconButton(
          onPressed: () {
            //ref.read(pageIndexProvider.notifier).nextIndex();
          },
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }

  void click(
      BuildContext context, List<CharacterModel> characterList, int index) {
    context.pushNamed(
      RoutePathEnum.characterDetail.path,
      pathParameters: {'id': characterList[index].id.toString()},
    );
  }
}
