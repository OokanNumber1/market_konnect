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

  Stream<User?> get authStateChanges => firebaseAuth.idTokenChanges();
  User? get currentUser => firebaseAuth.currentUser;
  //MarketUser? get currentMarketUser => MarketUser.fromMap(firestore.collection(FirestoreCollection.marketUsers).get(""));

  Future<void> googleSignIn() async {
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
    return null;
  }

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
        throw const AuthException(errorMessage: "Kindly verify the verification link sent to the provided mail");
      }
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
    } on FirebaseException catch (e){
      throw AuthException(errorMessage: e.message!);
    }
  }

  void signOut() async {
    await googleAuth.signOut();
    await firebaseAuth.signOut();
  }

  Future<void> saveUser(SignupDTO signupDto) async {
    await firestore
        .collection(FirestoreCollection.marketUsers)
        .doc(currentUser!.uid)
        .set(signupDto.toMap());
  }

//DocumentSnapshot<Map<String, dynamic>>
  Future<MarketUser> getUser(String uid) async {
    final docSnap = await firestore
        .collection(FirestoreCollection.marketUsers)
        .doc(uid)
        .get();
    //final docToMap = docSnap.data();
    return MarketUser.fromDocumentSnapshot(docSnap);
    //return MarketUser.fromMap(docToMap ?? {});
  }
}

final authRepoProvider = Provider((ref) {
  return AuthRepository(
    firebaseAuth: FirebaseAuth.instance,
    googleAuth: GoogleSignIn(),
    firestore: FirebaseFirestore.instance,
  );
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepoProvider).authStateChanges;
});

final currentUser = Provider((ref)=>ref.read(authRepoProvider).currentUser);
