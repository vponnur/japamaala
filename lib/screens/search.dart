import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:japamala/models/constants.dart';
import 'package:japamala/models/group.dart';
import 'package:japamala/services/helperFunctions.dart';
import 'package:japamala/widgets/commonWidget.dart';
import 'package:japamala/widgets/groupResult.dart';
import 'package:japamala/widgets/progress.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchResultsFuture;
  String _favString;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarMain(context, title: "Search"),
      drawer: drawerMenu(context),
      body: ListView(
        children: [
          buildSearchField(),
          // buildSearchResults(),
          Container(
            height: MediaQuery.of(context).size.height - 150,
            child: searchResultsFuture == null
                ? buildNoContent()
                : buildSearchResults(),
          ),
          //searchResultsFuture == null ? buildNoContent() : buildSearchResults(),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   icon: Icon(
      //     Icons.add,
      //   ),
      //   backgroundColor: Colors.blueGrey[700],
      //   label: Text("New Group"),
      //   onPressed: createNewGroup,
      // ),
    );
  }

  buildSearchResults() {
    return FutureBuilder(
      future: searchResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }

        List<GroupResult> searchResults = [];
        snapshot.data.documents.forEach((doc) {
          Group group = Group.fromDocument(doc);
          GroupResult searchResult = GroupResult(group, _favString);
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
              "Search Group or\n  Add new group",
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

//SearchField script
  Container buildSearchField() {
    return Container(
      child: TextFormField(
        validator: (val) {
          if (val.isEmpty || val.length < 3) {
            return "Please enter minimum 3 characters";
          }
          return null;
        },
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search with Group name",
          filled: true, // backgroud color will filled
          prefixIcon: Icon(
            Icons.people,
            color: Colors.blue,
            size: 24.0,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            color: Colors.blue,
            iconSize: 28.0,
            onPressed: handleSearch,
          ),
        ),
      ),
    );
  }

  getFavouriteGroupString() async {
    _favString = await Group.getUserGroups(currentUser.id);
  }

  handleSearch() {
    String searchName = searchController.text.toLowerCase();
    //print('search result here : $searchName');
    if (searchName != "") {
      getFavouriteGroupString();
      Future<QuerySnapshot> grp = groupRef
          .where(Constants.groupName, isGreaterThanOrEqualTo: searchName)
          .get();
      setState(() {
        searchResultsFuture = grp;
      });
    }
  }

  //clear the search field
  clearSearch() {
    searchController.clear();
  }

  //Redirecting to CreateGroup screen
  // createNewGroup() {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (BuildContext context) => CreateGroup(),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
