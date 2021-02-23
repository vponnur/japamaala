import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:japamala/models/constants.dart';
import 'package:japamala/models/userActivity.dart';
import 'package:japamala/services/helperFunctions.dart';
import 'package:japamala/widgets/activityResults.dart';
import 'package:japamala/widgets/commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:japamala/widgets/progress.dart';

class ActivityFeed extends StatefulWidget {
  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  Future<QuerySnapshot> activityResultsFuture;

  @override
  void initState() {
    super.initState();
    activityPageInitial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, title: "Activity"),
      drawer: drawerMenu(context),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 150,
            child: activityResultsFuture == null
                ? buildNoContent()
                : buildActivityResults(),
          ),
        ],
      ),
    );
  }

  activityPageInitial() {
    Future<QuerySnapshot> actvt = userActivityRef
        //.where(Constants.groupName, isGreaterThanOrEqualTo: '')
        //.orderBy(Constants.groupName, descending: true)
        .where(Constants.dateTimeUA, isLessThanOrEqualTo: Timestamp.now())
        .orderBy(Constants.dateTimeUA, descending: true)
        .get();
    setState(() {
      activityResultsFuture = actvt;
    });
  }

  buildActivityResults() {
    return FutureBuilder(
      future: activityResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }

        List<ActivityResult> searchResults = [];
        snapshot.data.documents.forEach((doc) {
          UserActivity userActivity = UserActivity.fromDocument(doc);
          ActivityResult searchResult = ActivityResult(userActivity);
          searchResults.add(searchResult);
        });
        return ListView(
          children: searchResults,
        );
      },
    );
  }

  Container buildNoContent() {
    //final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      // height: 100,
      child: Center(
        child: ListView(
          //List view resizes it self
          children: <Widget>[
            //buildSearchField(),
            Text(
              "Go to Search tab and \n Find/Add your Favourite group",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                fontSize: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
