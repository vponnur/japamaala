import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:japamala/models/constants.dart';
import 'package:japamala/models/group.dart';
import 'package:japamala/services/helperFunctions.dart';

class UserActivity {
  final String id;
  final String userName;
  final String gothram;
  final String phoneNo;
  final String city;

  final String groupId;
  final String groupName;
  final String postedUserName;
  final String postedUserId;
  final int userTotalCount;
  final int groupTotalCount;
  final Timestamp dateTimeUA;

  UserActivity({
    this.id,
    this.userName,
    this.gothram,
    this.phoneNo,
    this.city,
    this.groupId,
    this.groupName,
    this.postedUserName,
    this.postedUserId,
    this.userTotalCount,
    this.groupTotalCount,
    this.dateTimeUA,
  });

  factory UserActivity.fromDocument(DocumentSnapshot doc) {
    return UserActivity(
      id: doc[Constants.id],
      userName: doc[Constants.userName],
      gothram: doc[Constants.gothram],
      phoneNo: doc[Constants.phoneNo],
      city: doc[Constants.city],
      groupId: doc[Constants.groupId],
      groupName: doc[Constants.groupName],
      postedUserName: doc[Constants.postedUserName],
      postedUserId: doc[Constants.postedUserId],
      userTotalCount: doc[Constants.userTotalCount],
      groupTotalCount: doc[Constants.groupTotalCount],
      dateTimeUA: doc[Constants.dateTimeUA],
    );
  }

  static createUserActivityGroup(UserActivity userActivity, DateTime dt) {
    var newId = HelperFunctions.getUserGroupId(
        userActivity.postedUserId, userActivity.groupId);
    //newID - userId_groupId
    createunAuthUsers(userActivity, dt, newId);

    //newID - userId_groupId_UUID
    newId = HelperFunctions.getUserGroupId(newId, HelperFunctions.getNewUUId());
    createUserActiviy(userActivity, dt, newId);

    Group.updateGroupTotalCount(
        userActivity.groupId, userActivity.userTotalCount);
  }

  static createunAuthUsers(
      UserActivity userActivity, DateTime dt, String newId) {
    unAuthUserRef.doc(newId).set({
      Constants.id: newId,
      Constants.userName: userActivity.userName,
      Constants.gothram: userActivity.gothram,
      Constants.phoneNo: userActivity.phoneNo,
      Constants.city: userActivity.city,
      Constants.postedUserId: userActivity.postedUserId,
      Constants.postedUserName: userActivity.postedUserName,
      Constants.dateTimeUA: dt == null ? timeStamp : dt,
    });
  }

  static createUserActiviy(
      UserActivity userActivity, DateTime dt, String newId) {
    userActivityRef.doc(newId).set({
      Constants.id: newId,
      Constants.userName: userActivity.userName,
      Constants.gothram: userActivity.gothram,
      Constants.phoneNo: userActivity.phoneNo,
      Constants.city: userActivity.city,
      Constants.postedUserId: userActivity.postedUserId,
      Constants.postedUserName: userActivity.postedUserName,
      Constants.groupId: userActivity.groupId,
      Constants.groupName: userActivity.groupName,
      Constants.userTotalCount: userActivity.userTotalCount,
      Constants.groupTotalCount: userActivity.groupTotalCount,
      Constants.dateTimeUA: dt == null ? timeStamp : dt,
    });
  }
}
