import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  //! 1.Making Static KEYS for using in shared pref=====
  static String sharedPrefUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPrefUserNamenKey = "USERNAMEKEY";
  static String sharedPrefUserEmailKey = "USEREMAILKEY";
  static String sharedPrefUserPassWordKey = "USERPASSWORDKEY";

  //! 2. Savig data to Shared Pref=====

  static Future<bool> saveUserLoggedInSharedPref(bool isUserLoggedIn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setBool(sharedPrefUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPref(String userName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(sharedPrefUserNamenKey, userName);
  }

  static Future<bool> saveUserEmailSharedPref(String userEmail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(sharedPrefUserEmailKey, userEmail);
  }

  static Future<bool> saveUserPassSharedPref(String userPass) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(sharedPrefUserPassWordKey, userPass);
  }

  //! 3. getting data from sharedpref========

  static Future<bool?> getUserLoggedInSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(sharedPrefUserLoggedInKey);
  }

  static Future<String?> getUserNameSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(sharedPrefUserNamenKey);
  }

  static Future<String?> getUserEmailSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(sharedPrefUserEmailKey);
  }

  static Future<String?> getUserPassSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(sharedPrefUserPassWordKey);
  }
}
