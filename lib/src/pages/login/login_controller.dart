import 'package:flutter/material.dart';
import 'package:uber_clone/src/providers/auth_provider.dart';
import 'package:uber_clone/src/utils/snackbar.dart' as utils;

class LoginController {
  BuildContext? context;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  AuthProvider? _authProvider;

  Future? init(BuildContext context) {
    this.context = context;

    _authProvider = new AuthProvider();
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email: $email');
    print('Password: $password');

    try {
      bool isLogin = await _authProvider!.login(email, password);

      if (isLogin) {
        print('yes');
      } else {
        print('no');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context!, 'register');
  } 
}
