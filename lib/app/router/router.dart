import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kross/app/features/home/home_screen.dart';
import 'package:kross/app/features/inside_the_house/inside_the_house_screen.dart';
import 'package:kross/di/di.dart';
import 'package:talker_flutter/talker_flutter.dart';
final GlobalKey<NavigatorState> _rootNavigationKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  observers: [TalkerRouteObserver(talker)],
  initialLocation: '/home',
  routes: <RouteBase>[
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) {
        return NoTransitionPage<void>(
          key: state.pageKey,
          child: const HomeScreen(),
        );
      },
    ),
    GoRoute(
      path: '/inside_the_house_screen/:title/:description/:imageUrl',
      pageBuilder: (context, state) {
        final title = state.pathParameters['title'] ?? '';
        final description = state.pathParameters['description'] ?? '';
        final imageUrl = state.pathParameters['imageUrl'] ?? '';

        return NoTransitionPage<void>(
          key: state.pageKey,
          child: InsideTheHouse(
            title: title,
            description: description,
            imageUrl: imageUrl,
          ),
        );
      },
    ),
  ],
);