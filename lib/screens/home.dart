import 'package:flutter/material.dart';
import 'package:japamala/screens/loginUserScreen.dart';
import 'package:japamala/services/helperFunctions.dart';
import 'package:japamala/widgets/homeNavigations.dart';

class Home extends StatefulWidget {
  // final int indexHomeTab;
  // Home({this.indexHomeTab = 0});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    HelperFunctions.getUserLoggedInSP().then((isUserAuth) {
      //print("Home : $isUserAuth");
      setState(() {
        isAuth = isUserAuth;
      });
    });
  }

  Widget build(BuildContext context) {
    return isAuth ? HomeNavigations() : LoginUserScreen();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
