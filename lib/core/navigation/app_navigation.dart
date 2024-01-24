import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/feature/character/presentation/ui/character_detail_screen.dart';
import 'package:rick_morty_api/feature/character/presentation/ui/character_screen.dart';
import 'package:rick_morty_api/feature/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:rick_morty_api/feature/episode/presentation/ui/episode_screen.dart';
import 'package:rick_morty_api/feature/location/presentation/ui/location_screen.dart';
import 'package:rick_morty_api/feature/setting/presentation/setting_screen.dart';

enum RoutePathEnum {
  episode(path: '/episode'),
  character(path: '/character'),
  characterDetail(path: 'characterDetail'),
  location(path: '/location'),
  setting(path: '/setting'),
  ;

  const RoutePathEnum({required this.path});
  final String path;
}

class AppNavigation {
  AppNavigation._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey(debugLabel: 'root');

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePathEnum.character.path,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return DashboardScreen(child: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: RoutePathEnum.character.path,
                name: RoutePathEnum.character.name,
                routes: [
                  GoRoute(
                    path: '${RoutePathEnum.characterDetail.path}:id',
                    name: RoutePathEnum.characterDetail.name,
                    pageBuilder: (context, state) {
                      return NoTransitionPage(
                        child: CharacterDetailScreen(
                          key: state.pageKey,
                          id: state.pathParameters['id'] ?? '',
                        ),
                      );
                    },
                  ),
                ],
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: CharacterScreen(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: RoutePathEnum.episode.path,
                name: RoutePathEnum.episode.name,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: EpisodeScreen(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: RoutePathEnum.location.path,
                name: RoutePathEnum.location.name,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: LocationScreen(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: RoutePathEnum.setting.path,
                name: RoutePathEnum.setting.name,
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
        ],
      ),
    ],
  );
}
