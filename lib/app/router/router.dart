import 'package:go_router/go_router.dart';
import 'package:kross/app/features/favorites/favorites_screen.dart';
import 'package:kross/app/features/features.dart';
import 'package:kross/di/di.dart';
import 'package:talker_flutter/talker_flutter.dart';
final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  observers: [TalkerRouteObserver(talker)],
  initialLocation: '/auth',
  routes: <RouteBase>[
    GoRoute(
      path: '/auth',
      pageBuilder: (context, state) {
        return NoTransitionPage<void>(
          key: state.pageKey,
          child: const AuthPage(),
        );
      },
    ),
    GoRoute(
      path: '/reg',
      pageBuilder: (context, state) {
        return NoTransitionPage<void>(
          key: state.pageKey,
          child: const RegistrationPage(),
        );
      },
    ),
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
    GoRoute(
      path: '/favorites',
      pageBuilder: (context, state) {
        return NoTransitionPage<void>(
          key: state.pageKey,
          child: const FavoritesScreen(),
        );
      },
    ),
  ],
);