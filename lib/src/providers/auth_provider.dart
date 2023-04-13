import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider {
  FirebaseAuth? _firebaseAuth;

  AuthProvider() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  User? getUser() {
    return _firebaseAuth?.currentUser;
  }

  void checkIfUserIsLogged(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print('=============== el usuario esta logeado');
        Navigator.pushNamedAndRemoveUntil(
            context, 'client/map', (route) => false);
      } else {
        print('=============== el usuario no esta logeado');
      }
    });
  }

  Future<bool> login(String email, String password) async {
    String? errorMessage;

    try {
      await _firebaseAuth!
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      print(error);
      errorMessage = error.toString();
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }

    return true;
  }

  Future<bool> register(String email, String password) async {
    String? errorMessage;

    try {
      await _firebaseAuth!
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      print(error);
      errorMessage = error.toString();
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }

    return true;
  }
}
