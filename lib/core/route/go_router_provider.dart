import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/core/route/route_name.dart';
import 'package:rick_morty_api/feature/character/presentation/ui/character_detail_screen.dart';
import 'package:rick_morty_api/feature/character/presentation/ui/character_screen.dart';
import 'package:rick_morty_api/feature/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:rick_morty_api/feature/episode/presentation/ui/episode_screen.dart';
import 'package:rick_morty_api/feature/location/presentation/ui/location_screen.dart';
import 'package:rick_morty_api/feature/setting/presentation/setting_screen.dart';

class GoRouterProvider {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey(debugLabel: 'root');
  final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey(debugLabel: 'shell');
  GoRouter goRouter() {
    return GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: '/episode',
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              return DashboardScreen(
                key: state.pageKey,
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: '/episode',
                name: RouteNames.episodeRoute,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: EpisodeScreen(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/character',
                name: RouteNames.characterRoute,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: CharacterScreen(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/location',
                name: RouteNames.locationRoute,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: LocationScreen(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/setting',
                name: RouteNames.settingRoute,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: SettingScreen(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
            ],
          ),
        ]);
  }
}
