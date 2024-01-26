import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/app/navigation/app_navigation.dart';
import 'package:rick_morty_api/feature/character/domain/entities/character_entity.dart';
import 'package:rick_morty_api/feature/character/presentation/detail/state/detail_page_notifier.dart';
import 'package:rick_morty_api/feature/character/presentation/list/state/character_page_notifier.dart';
import 'package:rick_morty_api/feature/character/presentation/list/state/character_page_state.dart';
import 'package:rick_morty_api/feature/character/presentation/list/widget/list_item.dart';
import 'package:rick_morty_api/feature/character/presentation/list/widget/list_item_header.dart';
import 'package:rick_morty_api/feature/character/presentation/list/widget/list_loading.dart';

// -----------------------------------------------------------------------------
// Page
// -----------------------------------------------------------------------------
class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CharacterView();
  }
}

// -----------------------------------------------------------------------------
// View
// -----------------------------------------------------------------------------
class CharacterView extends ConsumerStatefulWidget {
  const CharacterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterViewState();
}

class _CharacterViewState extends ConsumerState<CharacterView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(characterPageStateProvider.notifier).fetchNextPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(
      characterPageStateProvider.select((p) => p.status),
    );

    return status == CharacterPageStatus.initial
        ? const Center(child: CircularProgressIndicator())
        : const _Content();
  }
}

// -----------------------------------------------------------------------------
// Content
// -----------------------------------------------------------------------------
class _Content extends ConsumerStatefulWidget {
  const _Content({
    super.key,
  });

  @override
  ConsumerState<_Content> createState() => __ContentState();
}

class __ContentState extends ConsumerState<_Content> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final state = ref.watch(characterPageStateProvider);
          final list = state.characters;
          final hasEnded = state.hasReachedEnd;

          return ListView.builder(
            key: const ValueKey('character_page_list_key'),
            controller: _scrollController,
            itemCount: hasEnded ? list.length : list.length + 1,
            itemBuilder: (context, index) {
              if (index >= list.length) {
                return !hasEnded
                    ? const CharacterListItemLoading()
                    : const SizedBox();
              }
              final item = list[index];
              return index == 0
                  ? Column(
                      children: [
                        const CharacterListItemHeader(
                          titleText: 'All Characters',
                        ),
                        CharacterListItem(
                          item: item,
                          onTap: (character) {
                            _goToDetailsPage(context, ref, character);
                          },
                        ),
                      ],
                    )
                  : CharacterListItem(
                      item: item,
                      onTap: (character) {
                        _goToDetailsPage(context, ref, character);
                      },
                    );
            },
          );
        },
      ),
    );
  }

  void _goToDetailsPage(
      BuildContext context, WidgetRef ref, CharacterEntity character) {
    ref.read(characterDetailsPageProvider.notifier).setCharacter(character);
    context.pushNamed(
      RoutePathEnum.characterDetail.path,
      pathParameters: {'id': character.id.toString()},
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      ref.read(characterPageStateProvider.notifier).fetchNextPage();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    return _scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange;
  }
}
