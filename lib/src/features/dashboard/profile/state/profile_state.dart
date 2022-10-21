import 'package:market_connect/src/features/authentication/model/market_user.dart';

enum ViewState {idle,loading,success,failure}

class ProfileState {
   ProfileState({
     this.viewState = ViewState.idle,
     this.user,
     this.errorMessage,
  });
  final ViewState viewState;
  final MarketUser? user;
  final String? errorMessage;
 

  ProfileState copyWith({
    ViewState? viewState,
    MarketUser? user,
    String? errorMessage,
  }) {
    return ProfileState(
      viewState: viewState ?? this.viewState,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
