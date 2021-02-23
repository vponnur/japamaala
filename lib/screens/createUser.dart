import 'dart:async';
import 'package:japamala/widgets/commonWidget.dart';
import 'package:flutter/material.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String _userName;

  submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      SnackBar snackbar = SnackBar(
        content: Text('Welcome $_userName'),
      );
      _scaffoldKey.currentState.showSnackBar(snackbar);

      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, _userName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarMain(
        context,
        title: 'Profile',
        removeBackButton: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Center(
                    child: const Text(
                      "Profile",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: TextFormField(
                        validator: (val) {
                          if (val.trim().length < 3 || val.isEmpty) {
                            return "username too short.";
                          } else if (val.length > 12) {
                            return "username too long";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (val) {
                          _userName = val;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'username',
                            labelStyle: TextStyle(fontSize: 15),
                            hintText: 'username must be 3 characters'),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: submit,
                  child: Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
