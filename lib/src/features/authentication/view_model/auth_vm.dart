import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/state/auth_state.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/authentication/model/signup_dto.dart';
import 'package:market_connect/src/features/authentication/repository/auth_repo.dart';
import 'package:market_connect/src/utilities/enums/enums.dart';
import 'package:market_connect/src/utilities/exception/exception.dart';

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel({required this.authRepository}) : super(const AuthState());
  final AuthRepository authRepository;

  //MarketUser? get currentUser => authRepository.currentUser;
  MarketUser? currentMarketUser;
  

  void emailPasswordSignUp(SignupDTO signUpDto) async {
    state = state.copyWith(authViewState: ViewState.loading);
    try {
      //final signedUser = 
     await authRepository.emailPasswordSignUp(signUpDto);
      state = state.copyWith(
        authViewState: ViewState.success,
        //signedUser: signedUser,
      );
    } on AuthException catch (e) {
      state = state.copyWith(
        authViewState: ViewState.failure,
        errorMessage: e.errorMessage,
      );
    }
  }

  void emailPasswordSignIn(String email, String password) async {
    state = state.copyWith(authViewState: ViewState.loading);
    try {
      //final user =
      await authRepository.emailPasswordSignIn(email, password);
      state = state.copyWith(authViewState: ViewState.success);
    } on AuthException catch (e) {
      state = state.copyWith(errorMessage: e.errorMessage, authViewState: ViewState.failure,);
    }
  }

  void googleSignIn() async {
    state = state.copyWith(authViewState: ViewState.loading);
    try {
      //final user =
      await authRepository.googleSignIn();
      state = state.copyWith(
          //signedUser: MarketUser(uid: user?.uid ?? ""),
          authViewState: ViewState.success);
    } on AuthException catch (e) {
      state = state.copyWith(errorMessage: e.errorMessage);
    }
  }

  void signOut() async{
    state = state.copyWith(authViewState: ViewState.loading);
     authRepository.signOut();
     state = state.copyWith(authViewState: ViewState.success);
  }
}

final authVmProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(authRepository: ref.watch(authRepoProvider));
});

