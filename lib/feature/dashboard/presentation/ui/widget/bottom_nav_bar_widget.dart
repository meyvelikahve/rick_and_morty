import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBarWidget extends StatelessWidget {
  final StatefulNavigationShell child;
  const BottomNavBarWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: child.currentIndex,
      onDestinationSelected: (value) => _onItemSelected(value),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.list_alt), label: 'characters'),
        NavigationDestination(icon: Icon(Icons.list), label: 'episodes'),
        NavigationDestination(
            icon: Icon(Icons.list_alt_sharp), label: 'locations'),
      ],
    );
  }

  void _onItemSelected(int index) {
    child.goBranch(index);
  }
}
