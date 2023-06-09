import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/src/pages/client/client_map/client_map_page.dart';
import 'package:uber_clone/src/pages/driver/driver_map/driver_map_page.dart';
import 'package:uber_clone/src/pages/driver/driver_register/driver_register_page.dart';
import 'package:uber_clone/src/pages/home/home_page.dart';
import 'package:uber_clone/src/pages/login/login_page.dart';
import 'package:uber_clone/src/pages/client/client_register/client_register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Uber Cloone",
      initialRoute: 'home',
      theme: ThemeData(
        fontFamily: 'NimbusSans',
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
        primaryColor: Colors.black,
      ),
      routes: {
        'home': (BuildContext context) => HomePage(),
        'login': (BuildContext context) => LoginPage(),
        'client/register': (BuildContext context) => ClientRegisterPage(),
        'driver/register': (BuildContext context) => DriverRegisterPage(),
        'client/map': (BuildContext context) => ClientMapPage(),
        'driver/map': (BuildContext context) => DriverMapPage(),
      },
    );
  }
}
