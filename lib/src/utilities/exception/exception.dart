class AuthException implements Exception {
  const AuthException({required this.errorMessage});
  final String errorMessage;

  @override
  String toString() => 'AuthException(errorMessage: $errorMessage)';
}
