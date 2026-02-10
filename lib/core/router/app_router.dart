import 'package:backlog_roulette/core/router/route_names.dart';
import 'package:backlog_roulette/core/router/route_paths.dart';
import 'package:backlog_roulette/core/router/router_refresher.dart';
import 'package:backlog_roulette/features/auth/auth_di.dart';
import 'package:backlog_roulette/features/auth/views/screens/signin_screen.dart';
import 'package:backlog_roulette/features/auth/views/screens/signup_screen.dart';
import 'package:backlog_roulette/features/games/views/screens/game_details_screen.dart';
import 'package:backlog_roulette/features/home/views/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authNotifierProvider.notifier);

  return GoRouter(
    initialLocation: RoutePaths.signin,
    refreshListenable: RouterRefresher(authNotifier.build()),
    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);

      if (authState.isLoading || authState.hasError) return null;

      final bool loggedIn = authState.valueOrNull != null;

      final bool loggingIn =
          state.matchedLocation == RoutePaths.signin ||
          state.matchedLocation == RoutePaths.signup;

      if (!loggedIn && !loggingIn) return RoutePaths.signin;

      if (loggedIn && loggingIn) return RoutePaths.home;

      return null;
    },
    routes: [
      GoRoute(
        name: RouteNames.signin,
        path: RoutePaths.signin,
        builder: (context, state) => SigninScreen(),
      ),
      GoRoute(
        name: RouteNames.signup,
        path: RoutePaths.signup,
        builder: (context, state) => SignupScreen(),
      ),
      GoRoute(
        name: RouteNames.home,
        path: RoutePaths.home,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        name: RouteNames.gameDetails,
        path: RoutePaths.gameDetails,
        builder: (context, state) {
          final id = state.pathParameters['gameId']!;
          return GameDetailsScreen(gameId: id);
        },
      ),
    ],
  );
});
