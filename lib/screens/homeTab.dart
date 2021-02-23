import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:japamala/models/constants.dart';
import 'package:japamala/models/group.dart';
import 'package:japamala/services/helperFunctions.dart';
import 'package:japamala/widgets/commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:japamala/widgets/groupHome.dart';
import 'package:japamala/widgets/progress.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Future<QuerySnapshot> homeResultsFuture;
  @override
  void initState() {
    super.initState();
    homePageInitial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, title: "Home"),
      drawer: drawerMenu(context),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 150,
            child: homeResultsFuture == null
                ? buildNoContent()
                : buildFavouriteResults(),
          ),
        ],
      ),
    );
  }

  homePageInitial() {
    Future<QuerySnapshot> grp = groupRef
        .where(Constants.groupName, isGreaterThanOrEqualTo: '')
        .orderBy(Constants.groupName)
        .get();
    setState(() {
      homeResultsFuture = grp;
    });
  }

  buildFavouriteResults() {
    return FutureBuilder(
      future: homeResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }

        List<GroupHome> searchResults = [];
        snapshot.data.documents.forEach((doc) {
          Group group = Group.fromDocument(doc);
          GroupHome searchResult = GroupHome(group);
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
