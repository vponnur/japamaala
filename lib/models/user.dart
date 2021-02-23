import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:japamala/services/helperFunctions.dart';

import 'constants.dart';

class User {
  final String id;
  final String userName;
  final String email;
  final String photoUrl;
  final String displayName;
  final String bio;

  final String gothram;
  final String phoneNo;
  final String address;
  final String city;
  final String state;
  //final String timeStamp;

  User({
    this.id,
    this.userName,
    this.email,
    this.photoUrl,
    this.displayName,
    this.bio,
    this.gothram,
    this.phoneNo,
    this.address,
    this.city,
    this.state,
    //this.timeStamp
  });

//factory - like a static method
  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      userName: doc['userName'],
      email: doc['email'],
      photoUrl: doc['photoUrl'],
      displayName: doc['displayName'],
      bio: doc['bio'],
      gothram: doc['gothram'],
      phoneNo: doc['phoneNo'],
      address: doc['address'],
      city: doc['city'],
      state: doc['state'],
      //timeStamp: doc['timeStamp'],
    );
  }

  static createUser(User user) async {
    userRef.doc(user.id).set({
      Constants.id: user.id,
      Constants.userName: user.displayName,
      Constants.photoUrl: user.photoUrl,
      Constants.email: user.email,
      Constants.displayName: user.displayName,
      Constants.bio: user.bio,
      Constants.gothram: user.gothram,
      Constants.phoneNo: user.phoneNo,
      Constants.address: user.address,
      Constants.city: user.city,
      Constants.state: user.state,
      Constants.timeStamp: timeStamp
    });
  }

  static updateUser(User user) async {
    userRef.doc(user.id).update({
      ///Constants.id: user.id,
      Constants.userName: user.userName,
      //Constants.photoUrl: user.photoUrl,
      //Constants.email: user.email,
      Constants.displayName: user.displayName,
      //Constants.bio: user.bio,
      Constants.gothram: user.gothram,
      Constants.phoneNo: user.phoneNo,
      Constants.address: user.address,
      Constants.city: user.city,
      Constants.state: user.state,
      Constants.timeStamp: timeStamp
    });
  }
}
