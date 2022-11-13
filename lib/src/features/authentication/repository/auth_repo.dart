import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/authentication/model/signup_dto.dart';
import 'package:market_connect/src/utilities/constants/string_consts.dart';
import 'package:market_connect/src/utilities/exception/exception.dart';

class AuthRepository {
  const AuthRepository({
    required this.firebaseAuth,
    required this.googleAuth,
    required this.firestore,
  });
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleAuth;
  final FirebaseFirestore firestore;

  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get userStream => firebaseAuth.authStateChanges();

  //MarketUser? get currentMarketUser => MarketUser.fromMap(firestore.collection(FirestoreCollection.marketUsers).get(""));

 /* Future<void> googleSignIn() async {
    final googleAccount = await googleAuth.signIn();
    if (googleAccount != null) {
      final googleSignInAuth = await googleAccount.authentication;
      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );
      try {
        final userCred = await firebaseAuth.signInWithCredential(
          googleAuthCredential,
        );

        // return MarketUser(
        //   email: userCred.user!.email!,
        //   uid: userCred.user!.uid,
        //   marketName: userCred.user!.email!.split("@").join(),
        // );
      } on FirebaseAuthException catch (err) {
        throw AuthException(errorMessage: err.message!);
      }
    }
    return ;
  }*/

  //Future<MarketUser> emailPasswordSignIn(
  Future<void> emailPasswordSignIn(
    String email,
    String password,
  ) async {
    try {
      final signedUser = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (signedUser.user != null && !(signedUser.user!.emailVerified)) {
        throw const AuthException(
            errorMessage:
                "Kindly verify the verification link sent to the provided mail");
      }
      await firebaseAuth.currentUser!.reload();
      //return MarketUser(email: email, uid: userCred.user!.uid);
    } on FirebaseAuthException catch (e) {
      throw AuthException(errorMessage: e.message!);
    }
  }

  //Future<MarketUser>
  Future<void> emailPasswordSignUp(SignupDTO signUpDto) async {
    try {
      //final user =
      final signedUser = await firebaseAuth.createUserWithEmailAndPassword(
          email: signUpDto.email, password: signUpDto.password);

      await saveUser(signUpDto);
      await signedUser.user!.sendEmailVerification();

      //return MarketUser(email: signUpDto.email, uid: user.user!.uid,marketName: signUpDto.marketName);
    } on FirebaseAuthException catch (e) {
      throw AuthException(errorMessage: e.message!);
    } on FirebaseException catch (e) {
      throw AuthException(errorMessage: e.message!);
    }
  }

  void signOut() async {
    await googleAuth.signOut();
    await firebaseAuth.signOut();
  }

  Future<void> saveUser(SignupDTO signupDto) async {
    final marketUser = MarketUser(
      email: signupDto.email,
      uid: currentUser!.uid,
      marketName: signupDto.marketName,
      fullName: signupDto.fullName,
      about: "",
      photoUrl: "",
      followers: [],
      following: [],
    );
    await firestore
        .collection(FirestoreCollection.marketUsers)
        .doc(currentUser!.uid)
        .set(marketUser.toMap());
  }
}

final authRepoProvider = Provider((ref) {
  return AuthRepository(
    firebaseAuth: FirebaseAuth.instance,
    googleAuth: GoogleSignIn(),
    firestore: FirebaseFirestore.instance,
  );
});

final currentUser = Provider((ref) => ref.read(authRepoProvider).currentUser);
final authChangeProvider = StreamProvider((ref) {
  return ref.read(authRepoProvider).userStream;
});
