import 'package:flutter/material.dart';
import 'package:japamala/models/group.dart';
import 'package:japamala/services/helperFunctions.dart';
import 'package:japamala/widgets/commonWidget.dart';

class GroupResult extends StatelessWidget {
  final Group group;
  final String favourites;
  GroupResult(this.group, this.favourites);

  bool isFavouriteGroup(String groupId) {
    groupId = groupId.replaceAll('-', '');
    //print("fav : $favourites, $groupId");
    return favourites.contains(groupId);
  }

  addToFavorite(String groupId) async {
    Group.toggleUserGroup(currentUser.id, groupId);
    // print(
    //     "GroupId : ${HelperFunctions.getUserGroupId(currentUser.id, groupId)}");
  }

  @override
  Widget build(BuildContext context) {
    String _imgUrl = "assets/images/Jpm72.png";
    _imgUrl = group.groupPhotoUrl == "" ? _imgUrl : group.groupPhotoUrl;
    return Container(
      // height: MediaQuery.of(context).size.height,
      //color: Theme.of(context).primaryColor.withOpacity(0.7),
      color: Colors.white38,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => addToFavorite(
                group.groupId), // showProfile(context, profileId: user.id),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(_imgUrl),
              ),
              title: Text(
                group.groupName.toUpperCase(),
                style: simpleTextStyle(
                  color: Colors.cyan[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Owner : ${group.groupCreatedUserName}",
                style: simpleTextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Container(
                child: Icon(
                  isFavouriteGroup(group.groupId)
                      ? Icons.remove_circle
                      : Icons.add_circle,
                  color: isFavouriteGroup(group.groupId)
                      ? Colors.red[800]
                      : Colors.grey[850],
                  size: 30.0,
                ),
              ),
            ),
          ),
          Divider(
            height: 3.0,
            thickness: 1.0,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  // String subtitleWithUserName(String desc, String userName) {
  //   int lt = 10;
  //   int dlt = 20;
  //   String ds = desc.substring(0, (desc.length > dlt ? dlt : desc.length));
  //   String un =
  //       userName.substring(0, (userName.length > lt ? lt : userName.length));
  //   return "$ds ,\t\t\t Owner: $un";
  // }
}
