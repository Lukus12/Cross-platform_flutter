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
  navigatorKey: _rootNavigationKey,
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
      path: '/inside_the_house_screen',
      pageBuilder: (context, state) {
        return NoTransitionPage<void>(
          key: state.pageKey,
          child: const InsideTheHouse(),
        );
      },
    ),
  ],
);