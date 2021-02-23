import 'package:flutter/material.dart';
import 'package:japamala/services/helperFunctions.dart';
import 'package:japamala/widgets/commonWidget.dart';
import 'package:japamala/screens/home.dart';

class LoginUserScreen extends StatefulWidget {
  @override
  _LoginUserScreenState createState() => _LoginUserScreenState();
}

class _LoginUserScreenState extends State<LoginUserScreen> {
  bool isAuth = false;
  @override
  void initState() {
    super.initState();
    googleService.initgoogleSignIn(context).then((account) {
      //print("loginscreen output $account , $isAuth");
      setState(() {
        if (account != null) {
          isAuth = true;
        } else {
          isAuth = false;
        }
      });
    });
  }

  login() {
    googleService.googleLogin().then((account) {
      if (account != null) {
        setState(() {
          isAuth = true;
        });
      } else {
        setState(() {
          isAuth = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? Home() : buildLoginScreen();
  }

  Scaffold buildLoginScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.centerRight,
              colors: [
                //Colors.redAccent,
                Colors.grey,
                Colors.white,
                //Colors.amberAccent,
                Colors.grey,
              ]),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   width: 320,
            //   height: 120,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //     border: Border.all(color: Colors.grey),
            //     image: DecorationImage(
            //       image: AssetImage('assets/images/NeedIt_logo.png'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            Container(
              child: Text(
                "JapaMaala",
                style: logoTextStyle(
                    fontSize: 35,
                    color: Colors.blueGrey[900],
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                width: 200,
                height: 35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/google_signin_button.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
