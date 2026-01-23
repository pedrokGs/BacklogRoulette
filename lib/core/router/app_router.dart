import 'package:backlog_roulette/core/router/route_names.dart';
import 'package:backlog_roulette/core/router/route_paths.dart';
import 'package:backlog_roulette/di/notifiers.dart';
import 'package:backlog_roulette/features/auth/viewmodels/states/auth_state.dart';
import 'package:backlog_roulette/features/auth/views/screens/signin_screen.dart';
import 'package:backlog_roulette/features/auth/views/screens/signup_screen.dart';
import 'package:backlog_roulette/features/home/views/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref){
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: RoutePaths.signin,
    redirect: (context, state){
      final bool loggedIn = authState.maybeMap(authenticated: (_) => true, orElse: () => false);
      final bool loggingIn = state.matchedLocation == RoutePaths.signin;

      if(!loggedIn && !loggingIn) return RoutePaths.signin;


      if(loggedIn && loggingIn) return RoutePaths.home;

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
    ],
  );
});