import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/feature/dashboard/presentation/ui/widget/bottom_nav_bar_widget.dart';

class DashboardScreen extends StatelessWidget {
  final StatefulNavigationShell child;
  const DashboardScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavBarWidget(
        child: child,
      ),
    );
  }
}
