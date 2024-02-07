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
      destinations: [
        NavigationDestination(
            icon: SizedBox(
                height: 30,
                child: Image.asset('assets/icons/character_icon.png')),
            label: 'Characters'),
        NavigationDestination(
            icon: SizedBox(
                height: 30,
                child: Image.asset('assets/icons/episode_icon.png')),
            label: 'Episodes'),
        NavigationDestination(
            icon: SizedBox(
                height: 20,
                child: Image.asset('assets/icons/location_icon.png')),
            label: 'Locations'),
      ],
    );
  }

  void _onItemSelected(int index) {
    child.goBranch(index);
  }
}
