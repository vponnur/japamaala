import 'package:flutter/material.dart';
import 'package:japamala/models/userActivity.dart';
import 'package:japamala/widgets/commonWidget.dart';

class ActivityResult extends StatelessWidget {
  final UserActivity userActivity;

  ActivityResult(this.userActivity);

  String getDateFromDateTime(DateTime dt) {
    return dt.day.toString() +
        '/' +
        dt.month.toString() +
        '/' +
        dt.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    // redirectToUserCountPage(Group group) {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (BuildContext context) => UserCount(group),
    //     ),
    //   );
    // }

    return Container(
      //height: MediaQuery.of(context).size.height,
      //color: Theme.of(context).primaryColor.withOpacity(0.7),
      color: Colors.white38,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            onTap: null,
            child: ListTile(
              // leading: CircleAvatar(
              //   backgroundColor: Colors.white,
              //   //backgroundImage: AssetImage(_imgUrl),
              // ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      userActivity.groupName.toUpperCase(),
                      style: simpleTextStyle(
                        color: Colors.cyan[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    getDateFromDateTime(userActivity.dateTimeUA.toDate()),
                    style: simpleTextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "User : " + userActivity.userName,
                      style: simpleTextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    "Count : " + userActivity.userTotalCount.toString(),
                    style: simpleTextStyle(
                      color: Colors.teal[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              trailing: Container(
                child: IconButton(
                  onPressed: null, //() => print("Edit here"),
                  icon: Icon(Icons.edit),
                  color: Colors.blueAccent,
                  iconSize: 28,
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
