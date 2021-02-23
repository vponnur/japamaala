import 'package:flutter/material.dart';
import 'package:japamala/models/group.dart';
import 'package:japamala/screens/home.dart';
import 'package:japamala/widgets/commonWidget.dart';
import 'package:japamala/services/helperFunctions.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  //final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController groupNameController = TextEditingController();
  TextEditingController groupDesController = TextEditingController();

  createGroupToFireStore() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      Group grp = new Group(
        groupId: HelperFunctions.getNewUUId(),
        groupName: groupNameController.text,
        groupDescription: groupDesController.text,
        groupPhotoUrl: "",
        groupCreatedUserName: currentUser.userName,
        groupCreatedUserId: currentUser.id,
        groupTotalCount: 0,
        isActiveGroup: true,
      );
      Group.createGroup(grp);

      // SnackBar snackbar = SnackBar(
      //   content: Text('Group created.'),
      //   duration: Duration(seconds: 3),
      // );
      // _scaffoldKey.currentState.showSnackBar(
      //   snackbar,
      // );
      backToSearch();
    }
  }

  backToSearch() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Home(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      appBar: appBarMain(
        context,
        title: 'Group',
        //removeBackButton: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(50),
          // height: MediaQuery.of(context).size.height / 2 - 50,
          // width: MediaQuery.of(context).size.width - 100,
          // color: Colors.white54,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Provide Group Details",
                      style: simpleTextStyle(
                        color: Colors.indigo[800],
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (val) {
                      if (val.isEmpty || val.length < 5) {
                        return "Please enter Group Name(more that 5 chars)";
                      }
                      return null;
                    },
                    controller: groupNameController,
                    style: simpleTextStyle(),
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) => {},
                    decoration: textFieldInputDecoration(
                      hintText: "Group Name",
                      color: Colors.indigo[800],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (val) {
                      if (val.isEmpty || val.length < 5) {
                        return "Please enter Group Description";
                      }
                      return null;
                    },
                    controller: groupDesController,
                    style: simpleTextStyle(),
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) => {},
                    decoration: textFieldInputDecoration(
                      hintText: "Group Description",
                      color: Colors.indigo[800],
                    ),
                  ),
                ),
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
                          "Close",
                          style: simpleTextStyle(
                            color: Colors.indigo[800],
                          ),
                        ),
                        onPressed: backToSearch,
                      ),
                      TextButton.icon(
                        icon: Icon(
                          Icons.add_box,
                          color: Colors.indigo[800],
                        ),
                        label: Text(
                          "Add Group",
                          style: simpleTextStyle(
                            color: Colors.indigo[800],
                          ),
                        ),
                        onPressed: createGroupToFireStore,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
