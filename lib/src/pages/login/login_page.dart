import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:uber_clone/src/pages/login/login_controller.dart';
import 'package:uber_clone/src/utils/colors.dart' as utils;

import '../../widgets/button_app.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController _con = LoginController();

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
              _textDescription(),
              _txtLogin(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.17,
              ),
              _textFieldEmail(),
              _textFieldPassword(),
              _buttonLogin(),
              _dontHaveAccount(),
            ],
          ),
        ));
  }

  Widget _dontHaveAccount() => GestureDetector(
        onTap: _con.goToRegisterPage,
        child: Container(
          margin: EdgeInsets.only(bottom: 50),
          child: Text(
            'No tienes cuenta?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
        ),
      );

  Widget _buttonLogin() => Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        text: 'Iniciar Sesion',
        onPressed: _con.login,
      ));

  Widget _textFieldPassword() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: TextField(
          controller: _con.passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            suffixIcon: Icon(
              Icons.password_outlined,
              color: utils.Colors.uberCloneColor,
            ),
          ),
        ),
      );

  Widget _textFieldEmail() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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

  Widget _txtLogin() => Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      );

  Widget _textDescription() => Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Text(
          'Continua con tu',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 24,
            fontFamily: 'NimbusSans',
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
