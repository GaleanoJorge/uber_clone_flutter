import 'package:flutter/material.dart';
import 'package:uber_clone/src/models/client.dart';
import 'package:uber_clone/src/providers/auth_provider.dart';
import 'package:uber_clone/src/providers/client_provider.dart';
import 'package:uber_clone/src/utils/snackbar.dart' as utils;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:uber_clone/src/providers/auth_provider.dart';
import 'package:uber_clone/src/utils/progress_dialog.dart';

class ClientRegisterController {
  BuildContext? context;

  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  AuthProvider? _authProvider;
  ClientProvider? _clientProvider;
  ProgressDialog? _myProgressDialog;

  Future? init(BuildContext context) {
    this.context = context;

    _authProvider = new AuthProvider();
    _clientProvider = new ClientProvider();

    _myProgressDialog =
        MyProgressDialog.createPrograssDialog(context, 'Espere un momento...');
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
      utils.Snackbar.showSnackbarr(context!, 'debe ingresar todos los campos');
      print('debe ingresar todos los campos');
      return;
    }

    if (confirmPassword != password) {
      utils.Snackbar.showSnackbarr(context!, 'la contraseña no coincide');
      print('la contraseña no coincide');
      return;
    }

    if (password.length < 6) {
      utils.Snackbar.showSnackbarr(
          context!, 'la clave debe tener el menos 6 caracteres');
      print('la clave debe tener el menos 6 caracteres');
      return;
    }

    _myProgressDialog!.show();

    try {
      bool isRegister = await _authProvider!.register(email, password);

      if (isRegister) {
        Client client = Client(
            id: _authProvider!.getUser()!.uid,
            name: _authProvider!.getUser()!.email,
            email: email);

        print('=========================================================');
        await _clientProvider?.create(client);
        print('=========================================================');
        utils.Snackbar.showSnackbarr(context!, 'Usuario creado correctamente.');
        print('.................................yes');
      } else {
        utils.Snackbar.showSnackbarr(context!, 'Error al crear el usuario');
        print('.................................no');
      }

      _myProgressDialog!.hide();
      Navigator.pushNamedAndRemoveUntil(
          context!, 'client/map', (route) => false);
    } catch (error) {
      utils.Snackbar.showSnackbarr(context!, 'Error: $error');
      _myProgressDialog!.hide();
      print('Error: $error');
    }
  }
}
