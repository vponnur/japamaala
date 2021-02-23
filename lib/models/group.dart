import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:japamala/services/helperFunctions.dart';
import 'constants.dart';

class Group {
  final String groupId;
  final String groupName;
  final String groupDescription;
  final String groupPhotoUrl;
  final String groupCreatedUserName;
  final String groupCreatedUserId;
  final int groupTotalCount;
  final bool isActiveGroup;

  Group({
    this.groupId,
    this.groupName,
    this.groupDescription,
    this.groupPhotoUrl,
    this.groupCreatedUserName,
    this.groupCreatedUserId,
    this.groupTotalCount,
    this.isActiveGroup,
  });

  factory Group.fromDocument(DocumentSnapshot doc) {
    return Group(
      groupId: doc[Constants.groupId],
      groupName: doc[Constants.groupName],
      groupDescription: doc[Constants.groupDescription],
      groupPhotoUrl: doc[Constants.groupPhotoUrl],
      groupCreatedUserName: doc[Constants.groupCreatedUserName],
      groupCreatedUserId: doc[Constants.groupCreatedUserId],
      groupTotalCount: doc[Constants.groupTotalCount],
      isActiveGroup: doc[Constants.isActiveGroup],
    );
  }

  static createGroup(Group group) {
    groupRef.doc(group.groupId).set({
      Constants.groupId: group.groupId,
      Constants.groupName: group.groupName.toLowerCase(),
      Constants.groupDescription: group.groupDescription,
      Constants.groupPhotoUrl: group.groupPhotoUrl,
      Constants.groupCreatedUserName: group.groupCreatedUserName,
      Constants.groupCreatedUserId: group.groupCreatedUserId,
      Constants.groupTotalCount: group.groupTotalCount,
      Constants.isActiveGroup: group.isActiveGroup,
      Constants.timeStamp: timeStamp,
    });
  }

  //Create or delete -- toggle userGroup
  static Future<String> toggleUserGroup(String userId, String groupId) async {
    var id = HelperFunctions.getUserGroupId(userId, groupId);
    DocumentSnapshot doc = await userGroupRef.doc(id).get();
    //Toggle Add/Delete favourite
    if (!doc.exists) {
      userGroupRef.doc(id).set({
        Constants.id: id,
        Constants.userId: userId,
        Constants.groupId: groupId
      });
      return Constants.added;
    } else {
      userGroupRef.doc(id).delete();
      return Constants.deleted;
    }
  }

//Get all User Group Ids based on User/GroupId passed by param
  static Future<String> getUserGroups(String ugId) async {
    String fav = "";
    await userGroupRef.get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        if (element.id.contains(ugId)) {
          String gId = element.id.replaceAll(ugId, '');
          fav = "$fav$gId";
        }
      });
    });
    return fav;
  }

  static Future<String> updateGroupTotalCount(String groupId, int cnt) async {
    Group group;
    DocumentSnapshot doc = await groupRef.doc(groupId).get();
    if (doc.exists) {
      group = Group.fromDocument(doc);
      groupRef.doc(groupId).update({
        Constants.groupTotalCount: cnt + group.groupTotalCount,
      });
      return Constants.success;
    }
    return Constants.fail;
  }
} //Group
