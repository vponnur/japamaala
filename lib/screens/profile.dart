import 'package:flutter/material.dart';
import 'package:japamala/models/user.dart';
import 'package:japamala/services/helperFunctions.dart';
import 'package:japamala/widgets/commonWidget.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

// Future<void> getUserProfile() async {
//   //if (currentUser == null) {
//   //print("userId : ${currentUser.id}");
//   String userId = currentUser.id ?? await HelperFunctions.getUserId();
//   DocumentSnapshot userDoc = await userRef.doc(userId).get();
//   currentUser = User.fromDocument(userDoc);

//   /// }
// }

class _ProfileState extends State<Profile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController gothramController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  bool _isLoading = false;
  String _imgUrl =
      "https://lh3.googleusercontent.com/oIdWC4tdWKZG2knUZjlp-kktfln3xIFHnUX67Zwu_-QZc7o2wx-dmYvrOKKMNqrPnfJK";

  updateProfile(BuildContext context) {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      User user = new User(
        id: currentUser.id,
        userName: userNameController.text,
        displayName: userNameController.text,
        phoneNo: phoneNoController.text,
        gothram: gothramController.text,
        address: addressController.text,
        city: cityController.text,
        state: stateController.text,
      );
      User.updateUser(user);
      SnackBar snackbar = SnackBar(
        content: Text('Profile Updated.'),
        duration: Duration(seconds: 3),
      );
      _scaffoldKey.currentState.showSnackBar(
        snackbar,
      );

      // Timer(Duration(seconds: 2), () {
      //   Navigator.pop(context, _userName);
      // });
    }
  }

  mapUserDetails() {
    userNameController.text = currentUser.userName;
    phoneNoController.text = currentUser.phoneNo;
    gothramController.text = currentUser.gothram;
    addressController.text = currentUser.address;
    cityController.text = currentUser.city;
    stateController.text = currentUser.state;
    _imgUrl = currentUser.photoUrl == "" ? _imgUrl : currentUser.photoUrl;
    //print("_imgUrl: ${currentUser.phoneNo}");
  }

  @override
  void initState() {
    super.initState();
    getUserProfile().then((_) => mapUserDetails());
    // mapUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: appBarMain(
        context,
        title: 'Profile',
      ),
      drawer: drawerMenu(context),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                //height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.topCenter,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 1),
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: NetworkImage(_imgUrl),
                              // backgroundImage:
                              //     ExactAssetImage('assets/images/Jpm512.png'),
                              backgroundColor: Colors.transparent,
                            ),
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
                              onFieldSubmitted: (_) => updateProfile(context),
                              decoration:
                                  textFieldInputDecoration(hintText: "Name"),
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
                              onFieldSubmitted: (_) => updateProfile(context),
                              decoration: textFieldInputDecoration(
                                  hintText: 'Mobile no'),
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
                              onFieldSubmitted: (_) => updateProfile(context),
                              decoration:
                                  textFieldInputDecoration(hintText: 'Gothram'),
                            ),
                            TextFormField(
                              validator: (val) {
                                if (val.isEmpty || val.length > 30) {
                                  return "Please provide Address";
                                }
                                return null;
                              },
                              controller: addressController,
                              style: simpleTextStyle(),
                              keyboardType: TextInputType.emailAddress,
                              onFieldSubmitted: (_) => updateProfile(context),
                              decoration:
                                  textFieldInputDecoration(hintText: 'Address'),
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
                              onFieldSubmitted: (_) => updateProfile(context),
                              decoration:
                                  textFieldInputDecoration(hintText: 'City'),
                            ),
                            TextFormField(
                              validator: (val) {
                                if (val.isEmpty || val.length > 20) {
                                  return "Please provide State";
                                }
                                return null;
                              },
                              controller: stateController,
                              style: simpleTextStyle(),
                              keyboardType: TextInputType.text,
                              onFieldSubmitted: (_) => updateProfile(context),
                              decoration:
                                  textFieldInputDecoration(hintText: 'State'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => updateProfile(context),
                        child: Container(
                          alignment: Alignment.center,
                          width: 200,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0xff007EF4),
                              const Color(0xff2A75BC),
                            ]),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Update',
                            style: simpleTextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
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
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    super.dispose();
  }
}
