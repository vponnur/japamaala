import 'package:flutter/material.dart';
import 'package:japamala/screens/activityFeed.dart';
import 'package:japamala/screens/profile.dart';
import 'package:japamala/screens/search.dart';
import 'package:japamala/screens/homeTab.dart';

class HomeNavigations extends StatefulWidget {
  // final int indexHomeTab;

  // HomeNavigations({this.indexHomeTab});
  @override
  _HomeNavigationsState createState() => _HomeNavigationsState();
}

class _HomeNavigationsState extends State<HomeNavigations> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int pageIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
  );

  void onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onNavigationTap(int pageIndex) {
    pageController.jumpToPage(
      pageIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: null,
      body: PageView(
        children: <Widget>[
          HomeTab(), // Index = 0
          ActivityFeed(), // Index = 1
          // Upload(), // Index = 2
          Search(), // Index = 3
          Profile(), // Index = 4
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics:
            NeverScrollableScrollPhysics(), // user can not scrool these pages
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: onNavigationTap,
        backgroundColor: Colors.white12,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).accentColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              size: 35.0,
            ),
            label: 'Home', //Timeline
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Activity',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.photo_camera,
          //   ),
          //   label: 'Upload',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
