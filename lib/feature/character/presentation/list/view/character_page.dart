import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/character/presentation/list/controller/character_page_controller.dart';
import 'package:rick_morty_api/feature/character/presentation/list/controller/character_page_state.dart';
import 'package:rick_morty_api/feature/character/presentation/list/view/widget/list_item.dart';
import 'package:rick_morty_api/feature/character/presentation/list/view/widget/list_loading.dart';
import 'package:rick_morty_api/feature/character/presentation/list/view_model/character_page_view_model.dart';
import 'package:rick_morty_api/feature/shared_widgets/list_header_widget.dart';

class CharacterPage extends ConsumerStatefulWidget {
  const CharacterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterViewState();
}

class _CharacterViewState extends ConsumerState<CharacterPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(characterPageControllerProvider.notifier).fetchNextPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(
      characterPageControllerProvider.select((p) => p.status),
    );

    return status == CharacterPageStatus.initial
        ? const Center(child: CircularProgressIndicator())
        : const CharacterListView();
  }
}

class CharacterListView extends ConsumerStatefulWidget {
  const CharacterListView({
    super.key,
  });

  @override
  ConsumerState<CharacterListView> createState() => __ContentState();
}

class __ContentState extends CharacterListViewModel {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final state = ref.watch(characterPageControllerProvider);
          final list = state.characters;
          final hasEnded = state.hasReachedEnd;

          return ListView.builder(
            controller: scrollController,
            itemCount: hasEnded ? list.length : list.length + 1,
            itemBuilder: (context, index) {
              if (index >= list.length) {
                return !hasEnded
                    ? const Center(child: CharacterListItemLoading())
                    : const SizedBox();
              }
              final item = list[index];
              return index == 0
                  ? Column(
                      children: [
                        const ListHeaderWidget(
                          titleText: 'All Characters',
                        ),
                        CharacterListItem(
                          item: item,
                          onTap: (character) {
                            goToDetailsPage(context, ref, character);
                          },
                        ),
                      ],
                    )
                  : CharacterListItem(
                      item: item,
                      onTap: (character) {
                        goToDetailsPage(context, ref, character);
                      },
                    );
            },
          );
        },
      ),
    );
  }
}
