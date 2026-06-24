// routes.dart
import 'package:go_router/go_router.dart';
import 'package:semillas_app/views/screens/curiara_travel_screen.dart';
import 'package:semillas_app/views/screens/ebook_screen.dart';
import 'package:semillas_app/views/screens/grandfather_screen.dart';
import 'package:semillas_app/views/screens/start_screen.dart';
import 'package:semillas_app/views/screens/village_screen.dart';

class AppRoutes {
  static const String start = '/';
  static const String village = '/village';
  static const String curiaraTravel = '/curiara-travel';
  static const String grandfather = '/grandfather';
  static const String ebook = '/ebook';

  static final GoRouter router = GoRouter(
    initialLocation: start,
    routes: [
      GoRoute(
        path: start,
        name: 'start',
        builder: (context, state) => const StartScreen(),
      ),
      GoRoute(
        path: village,
        name: 'village',
        builder: (context, state) => const VillageScreen(),
      ),
      GoRoute(
        path: curiaraTravel,
        name: 'curiara-travel',
        builder: (context, state) => const CuriaraTravelScreen(),
      ),
      GoRoute(
        path: grandfather,
        name: 'grandfather',
        builder: (context, state) => const GrandfatherScreen(),
      ),
      GoRoute(
        path: ebook,
        name: 'ebook',
        builder: (context, state) => const EbookScreen(),
      ),
    ],
  );
}
