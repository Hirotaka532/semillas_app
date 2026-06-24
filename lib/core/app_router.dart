import 'package:go_router/go_router.dart';
import '../views/screens/start_screen.dart';
import '../views/screens/creation_screen.dart';
import '../views/screens/village_screen.dart';
import '../views/screens/curiara_travel_screen.dart';
import '../views/screens/grandfather_screen.dart';
import '../views/screens/ebook_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const StartScreen(),
    ),
    GoRoute(
      path: '/creation',
      builder: (context, state) => const CreationScreen(),
    ),
    GoRoute(
      path: '/village/:leader/:village',
      builder: (context, state) {
        final leader = state.pathParameters['leader'] ?? 'Invitado';
        final village = state.pathParameters['village'] ?? 'Mi Aldea';
        return VillageScreen(leaderName: leader, villageName: village);
      },
    ),
    GoRoute(
      path: '/curiara',
      builder: (context, state) => const CuriaraTravelScreen(),
    ),
    GoRoute(
      path: '/grandfather',
      builder: (context, state) => const GrandfatherScreen(),
    ),
    GoRoute(
      path: '/ebook',
      builder: (context, state) => const EbookScreen(),
    ),
  ],
);