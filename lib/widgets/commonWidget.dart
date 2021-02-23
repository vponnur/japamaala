import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:japamala/models/constants.dart';
import 'package:japamala/models/user.dart';
import 'package:japamala/screens/aboutScreen.dart';
import 'package:japamala/screens/createGroup.dart';
import 'package:japamala/screens/home.dart';
import 'package:japamala/screens/profile.dart';
import 'package:japamala/screens/reports.dart';
import 'package:japamala/services/helperFunctions.dart';
import 'package:japamala/services/shareService.dart';

Widget appBarMain(
  BuildContext context, {
  bool signOut = true,
  String title = "",
  bool removeBackButton = false,
  String filePath = "",
}) {
  return AppBar(
    automaticallyImplyLeading: !removeBackButton,
    title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Home(),
              ),
            );
          },
          child: Text(
            Constants.Japamala,
            style: logoTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.white70,
            ),
          ),
        ),
      ),
      Text(
        ' ~',
        style: logoTextStyle(
          fontSize: 18,
          color: Colors.blueGrey,
        ),
      ),
      Expanded(
          child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                title,
                style: logoTextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              )))
    ]),
    actions: [
      filePath == ""
          ? Text("")
          : IconButton(
              icon: Icon(
                Icons.save_alt,
                color: Colors.white70,
                size: 30,
              ),
              onPressed: null,
            ),
      filePath == ""
          ? Text("")
          : IconButton(
              icon: Icon(
                Icons.share_outlined,
                color: Colors.white70,
                size: 30,
              ),
              onPressed: null,
            ),
    ],
  );
}

Drawer drawerMenu(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.all(0),
      children: [
        Container(
          height: 90,
          decoration: BoxDecoration(
            color: Color(Constants.colorLinerBlue),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Home(),
                ),
              );
            },
            child: Row(
              children: [
                Expanded(
                  child: DrawerHeader(
                    //duration: Duration(seconds: 5),
                    child: Text(
                      Constants.Japamala,
                      style: logoTextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: 20,
                    top: 20,
                  ),
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundImage:
                        ExactAssetImage('assets/images/Jpm512.png'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
          thickness: 0.5,
          color: Colors.black54,
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
          leading: Icon(
            Icons.person,
            color: Colors.grey[700],
            size: 24,
          ),
          title: Text(
            'My Profile',
            style: simpleTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Profile(),
              ),
            );
          },
        ),
        Divider(
          height: 0,
          thickness: 0.5,
          color: Colors.black54,
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
          leading: Icon(
            Icons.home_work,
            color: Colors.grey[700],
            size: 24,
          ),
          title: Text(
            'New Group',
            style: simpleTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => CreateGroup(),
              ),
            );
          },
        ),
        Divider(
          height: 0,
          thickness: 0.5,
          color: Colors.black54,
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
          leading: Icon(
            Icons.edit,
            color: Colors.grey[700],
            size: 24,
          ),
          title: Text(
            'Records History',
            style: simpleTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (BuildContext context) => CreateGroup(),
            //   ),
            // );
          },
        ),
        Divider(
          height: 0,
          thickness: 0.5,
          color: Colors.black54,
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
          leading: Icon(
            Icons.add_chart,
            color: Colors.grey[700],
            size: 24,
          ),
          title: Text(
            'Reports',
            style: simpleTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Reports(),
              ),
            );
          },
        ),
        Divider(
          height: 0,
          thickness: 0.5,
          color: Colors.black54,
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
          leading: Icon(
            Icons.book,
            color: Colors.grey[700],
            size: 24,
          ),
          title: Text(
            'Books',
            style: simpleTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (BuildContext context) => CreateGroup(),
            //   ),
            // );
          },
        ),
        Divider(
          height: 0,
          thickness: 0.5,
          color: Colors.black54,
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
          leading: Icon(
            Icons.android,
            color: Colors.grey[700],
            size: 24,
          ),
          title: Text(
            'About Us',
            style: simpleTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => AboutScreen()));
          },
        ),
        Divider(
          height: 0,
          thickness: 0.5,
          color: Colors.black54,
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
          leading: Icon(
            Icons.share,
            color: Colors.grey[700],
            size: 24,
          ),
          title: Text(
            'Share App to Others',
            style: simpleTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            ShareService ss = ShareService();
            ss.shareToOthers();
          },
        ),
        Divider(
          height: 0,
          thickness: 0.5,
          color: Colors.black54,
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.grey[700],
            size: 24,
          ),
          title: Text(
            'Logout',
            style: simpleTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            googleService.googleLogOut();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
      ],
    ),
  );
}

DropdownButton appBarMenu(BuildContext context) {
  return DropdownButton(
    isExpanded: true,
    icon: Icon(
      Icons.more_vert,
      color: Colors.white,
    ),
    items: [
      DropdownMenuItem(
        value: 'logout',
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.exit_to_app),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Logout'),
                ],
              ),
            ],
          ),
        ),
      ),
      DropdownMenuItem(
        value: 'aboutUs',
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.android),
                  SizedBox(
                    width: 8,
                  ),
                  Text('AboutUs'),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
    onChanged: (ddSelectedValue) {
      if (ddSelectedValue == 'logout') {
        //To Do
        googleService.googleLogOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
      if (ddSelectedValue == 'aboutUs') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutScreen()));
      }
    },
  );
}

InputDecoration textFieldInputDecoration({
  String hintText,
  Color color = Colors.blueGrey,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: color),
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: color)),
  );
}

TextStyle simpleTextStyle({
  Color color = Colors.indigo,
  double fontSize = 16.0,
  bool underline = false,
  FontWeight fontWeight = FontWeight.normal,
  FontStyle fontStyle = FontStyle.normal,
  //String fontFamily = "Signatra",
}) {
  return TextStyle(
    //fontFamily: "Raleway",
    color: color,
    fontSize: fontSize,
    decoration: underline ? TextDecoration.underline : TextDecoration.none,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
  );
}

TextStyle logoTextStyle(
    {Color color = Colors.white,
    double fontSize = 11.0,
    bool underline = false,
    FontWeight fontWeight = FontWeight.normal}) {
  return TextStyle(
      fontFamily: "EagleLake",
      color: color,
      fontSize: fontSize,
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
      fontWeight: fontWeight);
}

//use ERROR in Msg
SnackBar showSnackBar({String msg = ""}) {
  bool isErrorMsg = msg.contains('ERROR');
  msg = isErrorMsg
      ? msg.replaceAll("ERROR", "").substring(0, 1).toUpperCase()
      : msg.substring(0, 1).toUpperCase();
  return SnackBar(
    content: Text(
      msg,
      style: TextStyle(
        color: isErrorMsg ? Colors.red : Colors.white,
      ),
    ),
    duration: Duration(seconds: 3),
    backgroundColor: Colors.black45,
  );
}

Future<void> getUserProfile() async {
  //if (currentUser == null) {
  //print("userId : ${currentUser.id}");
  String userId = currentUser.id ?? await HelperFunctions.getUserId();
  DocumentSnapshot userDoc = await userRef.doc(userId).get();
  currentUser = User.fromDocument(userDoc);

  /// }
}
