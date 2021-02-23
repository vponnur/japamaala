import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:japamala/models/constants.dart';
import 'package:japamala/models/user.dart';
import 'package:flutter/material.dart';
import 'package:japamala/services/helperFunctions.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<GoogleSignInAccount> initgoogleSignIn(BuildContext context) async {
    GoogleSignInAccount _account;
    googleSignIn.onCurrentUserChanged.listen((account) {
      _account = account;
      handleSignIn(context, account);
    });

    googleSignIn.signInSilently(suppressErrors: false).then(
      (account) {
        _account = account;
        handleSignIn(context, account);
      },
    ).catchError((error) {
      // print("initGoogle :$error");
    });
    return _account;
  }

  Future<GoogleSignInAccount> googleLogin() async {
    return await googleSignIn.signIn();
  }

  Future<GoogleSignInAccount> googleLogOut() async {
    HelperFunctions.setUserLoggedInSP(false);
    return await googleSignIn.signOut();
  }

  Future<void> handleSignIn(
      BuildContext context, GoogleSignInAccount account) async {
    if (account != null) {
      HelperFunctions.setUserLoggedInSP(true);
      await createUserInFireStore(context);
      //print("from here account : $account");
    }
  }

  Future<void> createUserInFireStore(BuildContext context) async {
    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot userDoc = await userRef.doc(user.id).get();
    if (!userDoc.exists) {
      // final userName = await Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CreateUser(),
      //   ),
      // );
      User newUser = new User(
        id: user.id,
        userName: user.displayName,
        photoUrl: user.photoUrl,
        email: user.email,
        displayName: user.displayName,
        bio: "Weclome to JapaMaala.",
      );

      User.createUser(newUser);
      // userRef.doc(user.id).set({
      //   Constants.id: user.id,
      //   Constants.userName: user.displayName,
      //   Constants.photoUrl: user.photoUrl,
      //   Constants.email: user.email,
      //   Constants.displayName: user.displayName,
      //   Constants.bio: "Weclome to JapaMaala.",
      //   Constants.timeStamp: timeStamp
      // });
      userDoc = await userRef.doc(user.id).get();
      //docs = await userRef.doc(user.id).snapshots().first;
    }
    currentUser = User.fromDocument(userDoc);
    HelperFunctions.setUserId(currentUser.id);
    HelperFunctions.setUserName(currentUser.userName);
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => Home()));
  }
} //GoogleService
