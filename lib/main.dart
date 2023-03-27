import 'package:flutter/material.dart';
import 'package:uber_clone/pages/home/home_page.dart';

void main() {
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
        fontFamily: 'NimbusSans'
      ),
      routes: {
        'home' : (BuildContext context) => HomePage(),
      },
    );
  }
}