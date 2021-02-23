import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:japamala/models/group.dart';
import 'package:japamala/models/userActivity.dart';
import 'package:japamala/screens/home.dart';
import 'package:japamala/services/helperFunctions.dart';
import 'package:japamala/widgets/commonWidget.dart';

class UserCount extends StatefulWidget {
  final Group group;
  UserCount(this.group);
  @override
  _UserCountState createState() => _UserCountState();
}

class _UserCountState extends State<UserCount> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController gothramController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countController = TextEditingController();
  int _itemCount = 0;
  DateTime _dateTime;
  String _errorText = "";
  backToSearch() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Home(),
      ),
    );
  }

  createUserGroupToFireStore() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (_itemCount != 0) {
        _errorText = "";
        UserActivity userActivity = new UserActivity(
          id: HelperFunctions.getNewUUId(),
          userName: userNameController.text,
          phoneNo: phoneNoController.text,
          gothram: gothramController.text,
          city: cityController.text,
          groupId: widget.group.groupId,
          groupName: widget.group.groupName,
          groupTotalCount: widget.group.groupTotalCount,
          postedUserName: currentUser.userName,
          postedUserId: currentUser.id,
          userTotalCount: _itemCount,
        );
        UserActivity.createUserActivityGroup(userActivity, _dateTime);

        SnackBar snackbar = SnackBar(
          content: Text('${userNameController.text} Count recorded.'),
          duration: Duration(seconds: 3),
        );
        _scaffoldKey.currentState.showSnackBar(
          snackbar,
        );
        backToSearch();
      } else {
        setState(() {
          _errorText = "Please provide count.";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String _imgUrl = "assets/images/Jpm72.png";
    _imgUrl =
        widget.group.groupPhotoUrl == "" ? _imgUrl : widget.group.groupPhotoUrl;
    // String _groupName = widget.group.groupName;
    // String _groupDesc = widget.group.groupDescription;
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarMain(
        context,
        title: 'Group',
        //removeBackButton: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          //height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 1),
                      CircleAvatar(
                        radius: 35.0,
                        backgroundImage: AssetImage(_imgUrl),
                        // backgroundImage:
                        //     ExactAssetImage('assets/images/Jpm512.png'),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(height: 2),
                      Text.rich(
                        TextSpan(
                          text: '', // default text style
                          children: <TextSpan>[
                            TextSpan(
                                text: widget.group.groupName.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.brown,
                                )),
                          ],
                        ),
                      ),
                      //SizedBox(height: 3),
                      Text.rich(
                        TextSpan(
                          text: '', // default text style
                          children: <TextSpan>[
                            TextSpan(
                                text: widget.group.groupDescription,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Colors.lightBlue[900],
                                )),
                          ],
                        ),
                      ),
                      // SizedBox(height: 1),
                      Container(
                        //width: 300,
                        height: 60,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Choose Count",
                                  style: simpleTextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo[200],
                                    fontSize: 18,
                                  ),
                                ),
                                new IconButton(
                                  icon: new Icon(
                                    Icons.remove_circle,
                                    color: Colors.indigo[800],
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(() => _itemCount--);
                                    _itemCount =
                                        _itemCount <= 0 ? 0 : _itemCount;

                                    countController.text =
                                        _itemCount.toString();

                                    _errorText = _itemCount == 0
                                        ? "Please provide count"
                                        : "";
                                  },
                                ),
                                IntrinsicWidth(
                                  child: TextField(
                                    controller: countController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      hintText: _itemCount.toString(),
                                    ),
                                    style: simpleTextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent,
                                      fontSize: 40,
                                    ),
                                    onChanged: (val) {
                                      //print("$val");
                                      setState(() {
                                        _itemCount = int.parse(val);
                                      });
                                    },
                                  ),
                                ),
                                new IconButton(
                                  icon: new Icon(
                                    Icons.add_circle,
                                    color: Colors.indigo[800],
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(() => _itemCount++);

                                    countController.text =
                                        _itemCount.toString();
                                    _errorText = _itemCount == 0
                                        ? "Please provide count"
                                        : "";
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _errorText,
                        style: simpleTextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        validator: (val) {
                          if (val.isEmpty || val.length < 5) {
                            return "Please provide Name(more that 5 chars)";
                          }
                          return null;
                        },
                        controller: userNameController,
                        style: simpleTextStyle(),
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) => createUserGroupToFireStore(),
                        decoration: textFieldInputDecoration(hintText: "Name"),
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val.isEmpty ||
                              (val.length < 1 && val.length > 11)) {
                            return "Please provide Mobile Number";
                          }
                          return null;
                        },
                        controller: phoneNoController,
                        style: simpleTextStyle(),
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (_) => createUserGroupToFireStore(),
                        decoration:
                            textFieldInputDecoration(hintText: 'Mobile no'),
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val.isEmpty || val.length > 20) {
                            return "Please provide Gothram";
                          }
                          return null;
                        },
                        controller: gothramController,
                        style: simpleTextStyle(),
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (_) => createUserGroupToFireStore(),
                        decoration:
                            textFieldInputDecoration(hintText: 'Gothram'),
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val.isEmpty || val.length > 20) {
                            return "Please provide City";
                          }
                          return null;
                        },
                        controller: cityController,
                        style: simpleTextStyle(),
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (_) => createUserGroupToFireStore(),
                        decoration: textFieldInputDecoration(hintText: 'City'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10),
                  //   color: Colors.grey[300],
                  // ),
                  height: 60,
                  child: CupertinoDatePicker(
                    backgroundColor: Colors.grey[300],
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (DateTime newDateTime) {
                      _dateTime = newDateTime;
                     // print("$_dateTime");
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        icon: Icon(
                          Icons.close_rounded,
                          color: Colors.indigo[800],
                        ),
                        label: Text(
                          "Cancle",
                          style: simpleTextStyle(
                            color: Colors.indigo[800],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: backToSearch,
                      ),
                      TextButton.icon(
                        icon: Icon(
                          Icons.add_box_rounded,
                          color: Colors.indigo[800],
                        ),
                        label: Text(
                          "Add Count to Group",
                          style: simpleTextStyle(
                            color: Colors.indigo[800],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: createUserGroupToFireStore,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    phoneNoController.dispose();
    gothramController.dispose();
    cityController.dispose();
    countController.dispose();

    super.dispose();
  }
}
