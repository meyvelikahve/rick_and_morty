import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/feature/dashboard/presentation/provider/nav_bar_provider.dart';

class BottomNavBarWidget extends ConsumerWidget {
  const BottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedIndex = ref.watch(navBarProvider);
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (value) => _onItemSelected(context, ref, value),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.list), label: 'episodes'),
        NavigationDestination(icon: Icon(Icons.list_alt), label: 'characters'),
        NavigationDestination(
            icon: Icon(Icons.list_alt_sharp), label: 'locations'),
        NavigationDestination(icon: Icon(Icons.settings), label: 'settings'),
      ],
    );
  }

  void _onItemSelected(BuildContext context, WidgetRef ref, int index) {
    ref.read(navBarProvider.notifier).setPageIndex(index);
    switch (index) {
      case 0:
        GoRouter.of(context).go('/episode');
        break;
      case 1:
        GoRouter.of(context).go('/character');
        break;
      case 2:
        GoRouter.of(context).go('/location');
        break;
      case 3:
        GoRouter.of(context).go('/setting');
        break;
      default:
        throw Exception('NavBar İndex Error');
    }
  }
}
