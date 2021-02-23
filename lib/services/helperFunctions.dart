import 'package:japamala/models/constants.dart';
import 'package:japamala/models/user.dart';
import 'package:japamala/services/googleService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

final fireStoreInstance = FirebaseFirestore.instance;
final userRef = FirebaseFirestore.instance.collection(Constants.users);
final groupRef = FirebaseFirestore.instance.collection(Constants.groups);

final userGroupRef =
    FirebaseFirestore.instance.collection(Constants.userGroups);
final userActivityRef =
    FirebaseFirestore.instance.collection(Constants.userActivity);
final unAuthUserRef =
    FirebaseFirestore.instance.collection(Constants.unAuthUsers);

User currentUser;
final DateTime timeStamp = DateTime.now();
GoogleService googleService = GoogleService();

class HelperFunctions {
  static String spIsUserLoggedIn = 'isUserLoggedIn';
  // static String spUserDetails = 'userDetails';
  static String spUserName = 'userName';
  // static String spUserEmail = 'userEmail';
  static String spUserId = 'userId';
  // static String spReceiverNameInKey = 'receiverName';
  // static String spReceiverEmailKey = 'receiverEmail';
  // static String spReceiverId = 'receiverId';

  static Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  //Set data to Shared preference
  static Future<void> setUserLoggedInSP(bool isUserLoggedIn) async {
    SharedPreferences pref = await _pref;
    return pref.setBool(spIsUserLoggedIn, isUserLoggedIn);
  }

  static Future<void> setUserName(String userName) async {
    SharedPreferences pref = await _pref;
    return pref.setString(spUserName, userName);
  }

  static Future<void> setUserId(String userID) async {
    SharedPreferences pref = await _pref;
    return pref.setString(spUserId, userID);
  }

  //Getting data from shared preferences
  static Future<bool> getUserLoggedInSP() async {
    SharedPreferences pref = await _pref;
    if (!pref.containsKey(spIsUserLoggedIn)) {
      return false;
    }
    return pref.getBool(spIsUserLoggedIn);
  }

  static Future<String> getUserName() async {
    SharedPreferences pref = await _pref;
    return pref.getString(spUserName);
  }

  static Future<String> getUserId() async {
    SharedPreferences pref = await _pref;
    return pref.getString(spUserId);
  }

  static Future<String> getUserIds() async {
    SharedPreferences pref = await _pref;
    return pref.getString(spUserId);
  }

  //Generating new UUID
  static getNewUUId() {
    return Uuid().v4().replaceAll('-', '');
  }

  static getUserGroupId(String userId, String groupId) {
    return "$userId\_${groupId.replaceAll('-', '')}";
  }

  static String getDateFormat(
      {String dateFormat = "DD-MM-YYYY", DateTime dateTime}) {
    DateTime dt = (dateTime != null) ? dateTime : DateTime.now();
    String dateString;
    String date = dt.day.toString();
    String month = dt.month.toString();
    String year = dt.year.toString();

    if (dateFormat == "DD-MM-YYYY") {
      dateString = date + '-' + month + '-' + year;
    }
    return dateString;
  }
}
