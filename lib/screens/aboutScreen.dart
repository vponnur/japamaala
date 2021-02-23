import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:japamala/services/adsMobService.dart';
import 'package:japamala/widgets/commonWidget.dart';

class AboutScreen extends StatefulWidget {
  AboutScreen({Key key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  AdsMobService _ams = AdsMobService();
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  final String msg = "is very simple and Secure Application." +
      "You can add your favorite chant group and Add your chanting count to that group." +
      "Its visible to all your friends and they can add their chant count in your common group.\n" +
      "Please provide your valuble inputs/suggetion to Us.";

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: _ams.getAdsMobAppId());
    _bannerAd = _ams.createBannerAd()
      ..load()
      ..show();

    _interstitialAd = _ams.createInterstitialAd()
      ..load()
      ..show();
  }

//   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarMain(context, title: "About Us"),
      drawer: drawerMenu(context),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text.rich(
              TextSpan(
                text: "\t JapaMaala ",
                style: simpleTextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: msg,
                    style: simpleTextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "\nEmail Us : Vijay.Ponnur@gmail.com",
              style: simpleTextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                //underline: true,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              child: Text(
                "Click Me.! Help Us..by watching Ads",
                style: simpleTextStyle(
                  color: Colors.blue[900],
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                _ams.createInterstitialAd()
                  ..load()
                  ..show();
              },
            ),
            Center(
              child: Image.asset(
                'assets/images/MakeInIndia.png',
                width: MediaQuery.of(context).size.width - 250,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }
}
