import 'package:shared_preferences/shared_preferences.dart';
class HelperFunctons{
  static String SharedPeferenceUserLogingKey="ISLOGGEDIN";
  static String SharedPeferenceUserNameKey="USERNAMEKEY";
  static String SharedPeferenceUserMailKey="USEREMAILKEY";
  static Future<bool>SaveUserLogin(bool isUserLogin)async{
      SharedPreferences preferences =await SharedPreferences.getInstance();
      return await preferences.setBool(SharedPeferenceUserLogingKey, isUserLogin);
  }
  static Future<bool>SaveUserName(String userName)async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    return await preferences.setString(SharedPeferenceUserNameKey, userName);
  }
  static Future<bool>SaveUserEmail(String Email)async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    return await preferences.setString(SharedPeferenceUserMailKey, Email);
  }


  static Future<bool>getUserlogin()async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    return await preferences.getBool(SharedPeferenceUserLogingKey);
  }
  static Future<String>getUserName()async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    return await preferences.getString(SharedPeferenceUserNameKey);
  }
  static Future<String>getUserEmail()async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    return await preferences.getString(SharedPeferenceUserMailKey);
  }

}