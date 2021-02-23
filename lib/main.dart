import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:japamala/models/constants.dart';
import 'package:japamala/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.Japamala,
      theme: ThemeData(
        primaryColor: Color(Constants.colorLinerBlue),
        scaffoldBackgroundColor: Colors.white70,
        primarySwatch: Colors.blue,
        accentColor: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}
