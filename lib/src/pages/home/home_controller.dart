import 'package:flutter/material.dart';
import 'package:uber_clone/src/providers/auth_provider.dart';
import 'package:uber_clone/src/utils/shared_pref.dart';

class HomeController {
  BuildContext? context;
  late SharedPref _sharedPref;

  late AuthProvider _authProvider;

  Future? init(BuildContext context) {
    this.context = context;

    _sharedPref = new SharedPref();
    _authProvider = new AuthProvider();
    _authProvider.checkIfUserIsLogged(context);
  }

  void goToLoginPage(String typeUser) {
    saveTypeUser(typeUser);
    Navigator.pushNamed(context!, 'login');
  }

  void saveTypeUser(String typeUser) async {
    await _sharedPref.save('typeUser', typeUser);
  }
}
