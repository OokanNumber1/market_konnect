import 'package:market_connect/src/utilities/enums/enums.dart';

class AuthState {
  final ViewState authViewState;
  final String? errorMessage;
  // final MarketUser? signedUser;
  const AuthState({
    this.authViewState = ViewState.initial,
    this.errorMessage,
    //this.signedUser,
  });

  AuthState copyWith({
    ViewState? authViewState,
    String? errorMessage,
    // MarketUser? signedUser,
  }) {
    return AuthState(
      authViewState: authViewState ?? this.authViewState,
      errorMessage: errorMessage ?? this.errorMessage,
      // signedUser: signedUser ?? this.signedUser,
    );
  }
}
