import 'package:backlog_roulette/features/home/views/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(name: 'home', path: '/', builder: (context, state) => HomeScreen()),
]);