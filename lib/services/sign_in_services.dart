import 'package:firebase_auth/firebase_auth.dart';

class SignInServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  SignInServices();
  Future<bool> isUserLoggedIn() async {
    User? user = auth.currentUser;
    return user != null;
  }

  Future createUser(Map<String, dynamic> userData) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: userData["password"],
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException();
      } else {
        throw ServerException();
      }
    }
  }

  Future loginUser(Map<String, dynamic> userData) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: userData["email"],
        password: userData["password"],
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException();
      } else {
        throw ServerException();
      }
    }
  }

  Future signOut() async {
    await auth.signOut();
  }
}

class UserNotFoundException implements Exception {}

class WrongPasswordException implements Exception {}

class WeakPasswordException implements Exception {}

class EmailAlreadyInUseException implements Exception {}

class ServerException implements Exception {}
