import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:uber_clone/src/providers/auth_provider.dart';
import 'package:uber_clone/src/utils/progress_dialog.dart';
import 'package:uber_clone/src/utils/shared_pref.dart';
import 'package:uber_clone/src/utils/snackbar.dart' as utils;

class LoginController {
  BuildContext? context;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  AuthProvider? _authProvider;
  ProgressDialog? _myProgressDialog;
  late SharedPref _sharedPref;

  String? _typeUser;

  Future? init(BuildContext context) async {
    this.context = context;

    _authProvider = new AuthProvider();
    _sharedPref = new SharedPref();
    _myProgressDialog =
        MyProgressDialog.createPrograssDialog(context, 'Espere un momento...');

    _typeUser = await _sharedPref.read('typeUser');

    print(_typeUser);
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
        _myProgressDialog!.hide();
        utils.Snackbar.showSnackbarr(context!, 'Usuario logeado.');
        print('yes');
        Navigator.pushNamedAndRemoveUntil(
            context!, 'client/map', (route) => false);
      } else {
        _myProgressDialog!.hide();
        utils.Snackbar.showSnackbarr(
            context!, 'El usuario no se pudo autentificar.');
        print('no');
      }
    } catch (error) {
      _myProgressDialog!.hide();
      utils.Snackbar.showSnackbarr(context!, 'Error: $error');
      print('Error: $error');
    }
  }

  void goToRegisterPage() {
    if (_typeUser == 'client') {
      Navigator.pushNamed(context!, 'client/register');
    } else {
      Navigator.pushNamed(context!, 'driver/register');
    }
  }
}
