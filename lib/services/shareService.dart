import 'package:share/share.dart';

class ShareService {
  String message;

  shareToOthers({message}) {
    message =
        "Hi, \n JapaMaala is a fast and simple and secure app.  I used to add daily chanting count also to check total group count, reports...etc and more fetures. \n Get it free at \n https://play.google.com/store/apps/details?id=com.vponnur.japamala";
    Share.share(message);
  }
}
