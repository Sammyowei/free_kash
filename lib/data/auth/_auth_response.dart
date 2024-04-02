sealed class AuthResponse {}

class SuccessAuthResponse extends AuthResponse {
  SuccessAuthResponse({this.message});
  final String? message;
}

class ErrorAuthResponse extends AuthResponse {
  ErrorAuthResponse(this.message, this.code);
  final String message;
  final String code;
}
