import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      return null;
    }
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//   scopes: ['email'],
// );

// Future<UserCredential?> signInWithGoogle() async {
//   try {
//     final GoogleSignInAccount? googleUser =
//         await _googleSignIn.signIn();

//     if (googleUser == null) return null;

//     final GoogleSignInAuthentication googleAuth =
//         await googleUser.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     return await FirebaseAuth.instance
//         .signInWithCredential(credential);

//   } catch (e) {
//     print("Google Sign-In Error: $e");
//     return null;
//   }
// }
}