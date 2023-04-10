import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:uber_clone/src/providers/auth_provider.dart';
import 'package:uber_clone/src/utils/progress_dialog.dart';
import 'package:uber_clone/src/utils/snackbar.dart' as utils;

class LoginController {
  BuildContext? context;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  AuthProvider? _authProvider;
  ProgressDialog? _myProgressDialog;

  Future? init(BuildContext context) {
    this.context = context;

    _authProvider = new AuthProvider();
    _myProgressDialog =
        MyProgressDialog.createPrograssDialog(context, 'Espere un momento...');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email: $email');
    print('Password: $password');

    _myProgressDialog!.show();

    try {
      bool isLogin = await _authProvider!.login(email, password);

      if (isLogin) {
        utils.Snackbar.showSnackbarr(context!, 'Usuario logeado.');
        print('yes');
      } else {
        utils.Snackbar.showSnackbarr(
            context!, 'El usuario no se pudo autentificar.');
        print('no');
      }

      _myProgressDialog!.hide();
    } catch (error) {
      _myProgressDialog!.hide();
      utils.Snackbar.showSnackbarr(context!, 'Error: $error');
      print('Error: $error');
    }
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context!, 'register');
  }
}
