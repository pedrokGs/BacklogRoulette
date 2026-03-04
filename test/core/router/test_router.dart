import 'package:backlog_roulette/core/router/route_names.dart';
import 'package:backlog_roulette/core/router/route_paths.dart';
import 'package:backlog_roulette/core/screens/home_screen.dart';
import 'package:backlog_roulette/features/auth/presentation/screens/signin_screen.dart';
import 'package:backlog_roulette/features/auth/presentation/screens/signup_screen.dart';
import 'package:backlog_roulette/features/games/presentation/screens/game_details_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter createTestRouter({String initialLocation = RoutePaths.signin}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        name: RouteNames.signin,
        path: RoutePaths.signin,
        builder: (context, state) => const SigninScreen(),
      ),
      GoRoute(
        name: RouteNames.signup,
        path: RoutePaths.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        name: RouteNames.home,
        path: RoutePaths.home,
        builder: (context, state) => const HomeScreen(),
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
}
