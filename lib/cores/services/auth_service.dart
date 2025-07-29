import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in - Bejelentkezés
  Future<String?> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Register - Regisztráció
  Future<String?> registerWithEmail(String email, String password, String firstName) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );


      await userCredential.user?.updateDisplayName(firstName);
      await userCredential.user?.reload();

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Unknown error occurred';
    }
  }


  // Sign out - Kijelentkezés
  Future<void> signOut() async => await _auth.signOut();

  // Auth state stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
