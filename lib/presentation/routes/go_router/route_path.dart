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

  /// Route Path for the account creation screen.
  static const String accountCreation = '/auth/signup/accountCreation';

  /// Route Path for the forgot password screen.
  static const String forgotPassword = '/auth/forgotPassword';

  /// Route Name for the confirmation screen after the password reset link has been sent.
  static const String confirmation = '/auth/forgotPassword/confirlmation';

  /// Route path for the signin screen.
  static String signIn = '/auth/signin';

  /// Route path for the onboarding screen.
  static String onboarding = '/:id/onboarding';

  /// Route path for the data validation screen to check if the user is logged in and has its data saved in the database
  static const String dataValidator = '/:id/validate';

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
