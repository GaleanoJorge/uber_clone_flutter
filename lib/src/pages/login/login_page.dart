import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:uber_clone/src/utils/Colors.dart' as utils;

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: utils.Colors.uberCloneColor,
        ),
        body: Column(
          children: [
            _bannerApp(),
            _textDescription(),
            _txtLogin(),
            Expanded(child: Container()),
            _textFieldEmail(),
            _textFieldPassword(),
            _buttonLogin(),
            _dontHaveAccount(),
          ],
        ));
  }

  Widget _dontHaveAccount() => Container(
    margin: EdgeInsets.only(bottom: 50),
    child: Text(
      'No tienes cuenta?',
      style: TextStyle(
        fontSize: 15,
        color: Colors.grey,
      ),
    ),
  );

  Widget _buttonLogin() => Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            'Iniciar Sesion',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            primary: utils.Colors.uberCloneColor,
          ),
        ),
      );

  Widget _textFieldPassword() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: TextField(
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
