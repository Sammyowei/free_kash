import 'package:free_kash/presentation/routes/go_router/route_name.dart';
import 'package:free_kash/presentation/routes/go_router/route_path.dart';
import 'package:free_kash/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

class NavRouter {
  static GoRouter route = GoRouter(
    initialLocation: RoutePath.initialRoute,
    routes: [
      GoRoute(
        path: RoutePath.initialRoute,
        name: RouteName.initialRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePath.authGateway,
        name: RouteName.authGateway,
        builder: (context, state) => const AuthGatewayScreen(),
      ),
      GoRoute(
        path: RoutePath.auth,
        name: RouteName.auth,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: RoutePath.signup,
        name: RouteName.signup,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: RoutePath.signIn,
        name: RouteName.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: RoutePath.dashboard,
        name: RouteName.dashboard,
        builder: (context, state) {
          return const DashBoard();
        },
      ),
    ],
  );
}
