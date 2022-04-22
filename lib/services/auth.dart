import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_make/model/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _userFromFirebase(User? user) {
    return user != null ? UserModel(userId: user.uid) : null;
  }

  Future signInWithEmail(String email, String pass) async {
    try {
      var result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      var firebaseUser = result.user;
      return _userFromFirebase(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmail(String email, String pass) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      var firebaseUser = result.user;
      return _userFromFirebase(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPass(String email, String pass) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
