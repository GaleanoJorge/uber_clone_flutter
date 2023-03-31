import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:uber_clone/src/pages/register/register_controller.dart';
import 'package:uber_clone/src/utils/Colors.dart' as utils;

import '../../widgets/button_app.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController _con = RegisterController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: utils.Colors.uberCloneColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _bannerApp(),
              _txtRegister(),
              _textFieldUserName(),
              _textFieldEmail(),
              _textFieldPassword(),
              _textFieldConfirmPassword(),
              _buttonRegister(),
            ],
          ),
        ));
  }

  Widget _buttonRegister() => Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        text: 'Registrarme',
        onPressed: _con.register,
      ));

  Widget _textFieldPassword() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: TextField(
          controller: _con.confirmPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            suffixIcon: Icon(
              Icons.lock_outline_rounded,
              color: utils.Colors.uberCloneColor,
            ),
          ),
        ),
      );

  Widget _textFieldConfirmPassword() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: TextField(
          controller: _con.passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirmar Contraseña',
            suffixIcon: Icon(
              Icons.lock_outline_rounded,
              color: utils.Colors.uberCloneColor,
            ),
          ),
        ),
      );

  Widget _textFieldUserName() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: TextField(
          controller: _con.userNameController,
          decoration: InputDecoration(
            hintText: 'Pepito Perez',
            labelText: 'Nombre de usuario',
            suffixIcon: Icon(
              Icons.person_2_outlined,
              color: utils.Colors.uberCloneColor,
            ),
          ),
        ),
      );

  Widget _textFieldEmail() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: TextField(
          controller: _con.emailController,
          decoration: InputDecoration(
            hintText: 'correo@mail.com',
            labelText: 'Correo electrónico',
            suffixIcon: Icon(
              Icons.email_outlined,
              color: utils.Colors.uberCloneColor,
            ),
          ),
        ),
      );

  Widget _txtRegister() => Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Text(
          'REGISTRO',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      );

  Widget _bannerApp() => ClipPath(
        clipper: WaveClipperTwo(),
        child: Container(
          color: utils.Colors.uberCloneColor,
          height: MediaQuery.of(context).size.height * 0.22,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/img/logo_app.png',
                width: 150,
                height: 100,
              ),
              Text(
                'Facil y Rapido',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
}
