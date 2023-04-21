import 'package:flutter/material.dart';
import 'package:uber_clone/src/models/driver.dart';
import 'package:uber_clone/src/providers/auth_provider.dart';
import 'package:uber_clone/src/providers/driver_provider.dart';
import 'package:uber_clone/src/utils/snackbar.dart' as utils;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:uber_clone/src/utils/progress_dialog.dart';

class DriverRegisterController {
  BuildContext? context;

  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  TextEditingController pinController1 = new TextEditingController();
  TextEditingController pinController2 = new TextEditingController();
  TextEditingController pinController3 = new TextEditingController();
  TextEditingController pinController4 = new TextEditingController();
  TextEditingController pinController5 = new TextEditingController();
  TextEditingController pinController6 = new TextEditingController();

  AuthProvider? _authProvider;
  DriverProvider? _driverProvider;
  ProgressDialog? _myProgressDialog;

  Future? init(BuildContext context) {
    this.context = context;

    _authProvider = new AuthProvider();
    _driverProvider = new DriverProvider();

    _myProgressDialog =
        MyProgressDialog.createPrograssDialog(context, 'Espere un momento...');
  }

  void register() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String userName = userNameController.text;
    String confirmPassword = confirmPasswordController.text.trim();

    String pin1 = pinController1.text.trim();
    String pin2 = pinController2.text.trim();
    String pin3 = pinController3.text.trim();
    String pin4 = pinController4.text.trim();
    String pin5 = pinController5.text.trim();
    String pin6 = pinController6.text.trim();

    String plate = '$pin1$pin2$pin3-$pin4$pin5$pin6';

    if (userName.isEmpty &&
        password.isEmpty &&
        userName.isEmpty &&
        pin1.isEmpty &&
        pin2.isEmpty &&
        pin3.isEmpty &&
        pin4.isEmpty &&
        pin5.isEmpty &&
        pin6.isEmpty &&
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
        Driver driver = Driver(
            id: _authProvider!.getUser()!.uid,
            name: _authProvider!.getUser()!.email,
            email: email,
            plate: plate);

        print('=========================================================');
        await _driverProvider?.create(driver);
        print('=========================================================');
        utils.Snackbar.showSnackbarr(context!, 'Usuario creado correctamente.');
        print('.................................yes');
      } else {
        utils.Snackbar.showSnackbarr(context!, 'Error al crear el usuario');
        print('.................................no');
      }

      _myProgressDialog!.hide();
      Navigator.pushNamedAndRemoveUntil(
          context!, 'driver/map', (route) => false);
    } catch (error) {
      utils.Snackbar.showSnackbarr(context!, 'Error: $error');
      _myProgressDialog!.hide();
      print('Error: $error');
    }
  }
}
