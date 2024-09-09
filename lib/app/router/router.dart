import 'package:go_router/go_router.dart';
import 'package:kross/app/features/features.dart';
import 'package:kross/di/di.dart';
import 'package:talker_flutter/talker_flutter.dart';
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
      path: '/inside_the_home_screen',
      pageBuilder: (context, state) {
        return NoTransitionPage<void>(
          key: state.pageKey,
          child: const InsideTheHomeScreen(),
        );
      },
    ),
  ],
);