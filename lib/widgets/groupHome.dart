import 'package:flutter/material.dart';
import 'package:japamala/models/group.dart';
import 'package:japamala/screens/userCount.dart';
import 'package:japamala/widgets/commonWidget.dart';

class GroupHome extends StatelessWidget {
  final Group group;
  GroupHome(this.group);

  @override
  Widget build(BuildContext context) {
    String _imgUrl = "assets/images/Jpm72.png";
    _imgUrl = group.groupPhotoUrl == "" ? _imgUrl : group.groupPhotoUrl;

    redirectToUserCountPage(Group group) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => UserCount(group),
        ),
      );
    }

    return Container(
      // height: MediaQuery.of(context).size.height,
      //color: Theme.of(context).primaryColor.withOpacity(0.7),
      color: Colors.white38,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: null, // showProfile(context, profileId: user.id),
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
                "Total Count : ${group.groupTotalCount}",
                style: simpleTextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Container(
                child: IconButton(
                  onPressed: () => redirectToUserCountPage(group),
                  icon: Icon(Icons.calculate),
                  color: Colors.blueAccent,
                  iconSize: 30,
                  //size: 30.0,
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
}
