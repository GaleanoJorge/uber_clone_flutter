import 'package:flutter/material.dart';
import 'package:uber_clone/src/providers/auth_provider.dart';

class RegisterController {
  BuildContext? context;

  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  AuthProvider? _authProvider;

  Future? init(BuildContext context) {
    this.context = context;

    _authProvider = new AuthProvider();
  }

  void register() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String userName = userNameController.text;
    String confirmPassword = confirmPasswordController.text.trim();

    if (userName.isEmpty &&
        password.isEmpty &&
        userName.isEmpty &&
        confirmPassword.isEmpty) {
      print('ddebe ingresar todos los campos');
      return;
    }

    if(confirmPassword != password) {
      print('la contraseña no coincide');
      return;
    }

    if(password.length < 6) {
      print('la clave debe tener el menos 6 caracteres');
      return;
    }

    try {
      bool isRegister = await _authProvider!.register(email, password);

      if (isRegister) {
        print('yes');
      } else {
        print('no');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
