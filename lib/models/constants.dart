class Constants {
  //Colors
  static const int colorLinerBlue = 0xff145C9E;
  static const int colorLinerBlack = 0xff1F1F1F;

  static const Japamala = "JapaMaala";
  static const japamalaTelugu = "జపమాల";
  static const timeStamp = "timeStamp";

  //Collections
  static const users = 'users';
  static const groups = 'groups';
  static const userGroups = 'userGroups';
  static const userActivity = 'userActivity';
  static const unAuthUsers = 'unAuthUsers';

  //User
  static const id = 'id';
  static const userName = 'userName';
  static const photoUrl = 'photoUrl';
  static const email = 'email';
  static const displayName = 'displayName';
  static const bio = 'bio';
  static const gothram = 'gothram';
  static const phoneNo = "phoneNo";
  static const address = "address";
  static const city = "city";
  static const state = "state";

  static const userId = 'userId';

  //Group
  static const groupId = 'groupId';
  static const groupName = 'groupName';
  static const groupDescription = 'groupDescription';
  static const groupPhotoUrl = 'groupPhotoUrl';
  static const groupCreatedUserName = 'groupCreatedUserName';
  static const groupCreatedUserId = 'groupCreatedUserId';
  static const groupTotalCount = 'groupTotalCount';
  static const isActiveGroup = 'isActiveGroup';

  //UserActiviy
  static const postedUserName = 'postedUserName';
  static const postedUserId = 'postedUserId';
  static const userTotalCount = 'userTotalCount';
  static const dateTimeUA = 'dateTimeUA';
  //Others
  static const success = 'success';
  static const fail = 'fail';
  static const added = 'added';
  static const deleted = 'deleted';
  static const appShareUrl =
      "https://play.google.com/store/apps/details?id=com.vponnur.japamala";
}

enum FeedType { Like, Comment, Follow }

class EnumHelper {
  static String getName(FeedType type) {
    switch (type) {
      case FeedType.Comment:
        return 'Comment';
      case FeedType.Like:
        return 'Like';
      case FeedType.Follow:
        return 'Follow';
      default:
        return null;
    }
  }
}
