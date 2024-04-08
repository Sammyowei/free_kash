import 'package:free_kash/presentation/routes/go_router/route_name.dart';
import 'package:free_kash/presentation/routes/go_router/route_path.dart';
import 'package:free_kash/presentation/screens/auth/forgot_password/confirmation_screen.dart';
import 'package:free_kash/presentation/screens/screens.dart';
import 'package:free_kash/presentation/screens/validator_screen/validator_screen.dart';
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
        path: RoutePath.accountCreation,
        name: RouteName.accountCreation,
        builder: (context, state) => const AccountCreationScreen(),
      ),
      GoRoute(
        path: RoutePath.forgotPassword,
        name: RouteName.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RoutePath.confirmation,
        name: RouteName.confirmation,
        builder: (context, state) {
          var param = state.uri.queryParameters;

          String email = 'test@user.com';

          final paramEmail = param['email'];

          if (paramEmail != null) {
            email = paramEmail;
          }

          return ForgetPasswordConfirmationScreen(
            email: email,
          );
        },
      ),
      GoRoute(
        path: RoutePath.signIn,
        name: RouteName.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: RoutePath.onboarding,
        name: RouteName.onboarding,
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),
      GoRoute(
        path: RoutePath.dashboard,
        name: RouteName.dashboard,
        builder: (context, state) {
          return const DashBoard();
        },
      ),
      GoRoute(
        path: RoutePath.dataValidator,
        name: RouteName.dataValidator,
        builder: (context, state) => const ValidatorScreen(),
      ),
    ],
  );
}
