import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';

class AdsMobService {
  static int adsMobBCount = 0;
  static int adsMobICount = 0;
  static const String _testDevice = "Mobile_Id";

  static const MobileAdTargetingInfo _targetingInfo = MobileAdTargetingInfo(
    testDevices: _testDevice != null ? <String>[_testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Japam', 'Japamala', 'Japa mala', 'japamaala'],
  );

  initAdsMob() {
    FirebaseAdMob.instance.initialize(appId: getAdsMobAppId());
  }

  String getAdsMobAppId() {
    if (Platform.isAndroid) {
      return "ca-app-pub-2538937533858268~2543330331";
    }
    return null;
  }

  String getBannerAdId({int index = 0}) {
    String adsId = "";
    if (Platform.isAndroid) {
      adsMobBCount = adsMobBCount < 3 ? adsMobBCount : adsMobBCount - 3;
      switch (adsMobBCount) {
        case 0:
          adsId = "ca-app-pub-2538937533858268/2925956796"; // Default
          break;
        case 1:
          adsId = "ca-app-pub-2538937533858268/2925956796"; // About
          break;
        case 2:
          adsId = "ca-app-pub-2538937533858268/2925956796"; // Home
          break;
        default:
          adsId = "ca-app-pub-2538937533858268/2925956796"; // Default
          break;
      }
      //print("adsMobBCount : $adsMobBCount, $adsId");
      adsMobBCount++;
    }
    return adsId;
  }

  String getInterstitialAd({int index = 0}) {
    String adsId = "";
    if (Platform.isAndroid) {
      adsMobICount = adsMobICount < 3 ? adsMobICount : adsMobICount - 3;
      switch (adsMobICount) {
        case 0:
          adsId = "ca-app-pub-2538937533858268/2303140266"; // Default
          break;
        case 1:
          adsId = "ca-app-pub-2538937533858268/2303140266"; // Chat
          break;
        case 2:
          adsId = "ca-app-pub-2538937533858268/2303140266"; // Home
          break;

        default:
          adsId = "ca-app-pub-2538937533858268/2303140266"; // Default
          break;
      }
      adsMobICount++;
    }
    return adsId;
  }

  BannerAd createBannerAd({int index = 0}) {
    return BannerAd(
        adUnitId: getBannerAdId(index: index),
        size: AdSize.banner,
        targetingInfo: _targetingInfo,
        listener: (MobileAdEvent event) {
          //print("BannerAdd : $event");
        });
  }

  InterstitialAd createInterstitialAd({int index = 0}) {
    return InterstitialAd(
        adUnitId: getInterstitialAd(index: index),
        targetingInfo: _targetingInfo,
        listener: (MobileAdEvent event) {
          //print("InterstitialAd : $event");
        });
  }
}
