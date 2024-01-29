import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/feature/character/presentation/list/ui/character_page.dart';
import 'package:rick_morty_api/feature/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:rick_morty_api/feature/episode/presentation/detail/ui/episode_detail_page.dart';
import 'package:rick_morty_api/feature/episode/presentation/list/ui/episode_page.dart';
import 'package:rick_morty_api/feature/location/presentation/ui/location_screen.dart';

import '../../feature/character/presentation/detail/ui/character_detail_screen.dart';

enum RoutePathEnum {
  character(path: '/character'),
  characterDetail(path: 'characterDetail'),
  episode(path: '/episode'),
  episodeDetail(path: 'episodeDetail'),
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
                        child: CharacterDetailsPage(
                          key: state.pageKey,
                        ),
                      );
                    },
                  ),
                ],
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: CharacterPage(
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
                routes: [
                  GoRoute(
                    path: '${RoutePathEnum.episodeDetail.path}:id',
                    name: RoutePathEnum.episodeDetail.name,
                    pageBuilder: (context, state) {
                      return NoTransitionPage(
                        child: EpisodeDetailPage(
                          key: state.pageKey,
                        ),
                      );
                    },
                  ),
                ],
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: EpisodePage(
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
        ],
      ),
    ],
  );
}
