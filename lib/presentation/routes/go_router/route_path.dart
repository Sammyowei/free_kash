/// A utility class for managing route paths within the application.
class RoutePath {
  /// The initial route path when the application starts.
  static String initialRoute = '/';

  /// Route path for authentication-related screens.
  static String auth = '/auth';

  /// Route path for the authentication gateway screen.
  static String authGateway = '/gateway';

  /// Route path for the signup screen.
  static String signup = '/auth/signup';

  /// Route path for the signin screen.
  static String signIn = '/auth/signin';

  /// Route path for the onboarding screen.
  static String onboarding = '/:id/onboarding';

  /// Route path for the dashboard screen.
  static String dashboard = '/:id';

  /// Route path for the profile screen.
  static String profile = '/:id/profile';

  /// Route path for the bank information screen within the profile.
  static String bank = '/:id/profile/bank';

  /// Route path for the wallet screen.
  static String wallet = '/:id/wallet';

  /// Route path for the earn screen.
  static String earn = '/:id/earn';

  /// Route path for the settings screen.
  static String settings = '/:id/settings';

  /// Route path for the referral screen.
  static String referral = ':id/referral';

  /// Route path for changing password within the profile settings.
  static String changePassword = '/:id/profile/updatePassword';
}
