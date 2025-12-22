import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/Data/Models/User_Model.dart';
// class of AuthController er kaj hoche ->
// 1) save or setting data into Local Memory
// 2) get data from Local Memory :
//      a) set the data into class of UserModel
class AuthController{
  static String _accessTokenKey = 'token';
  static String _userModelKey = 'user-data';
  static String ? accessToken;
  static UserModel ? userModel;

  // for setting values in Local Memory (SharedPreferences)
  static Future saveUserData( UserModel model, String token) async {
    // object create from Class of SharedPreference
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    accessToken = token;
    await sharedPreference.setString(_accessTokenKey, token);

    userModel = model;
    await sharedPreference.setString(
        _userModelKey,
        jsonEncode( model.toJson() ) // return convert Map<> to json String value
    );

  }

  // for getting values from Local Memory (SharedPreferences)
static Future getUserData () async{
    // object create
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String ? token = sharedPreference.getString(_accessTokenKey);

    if( token != null){
      // get the values from Local Memory (SharedPreferences)
      String ? userData = sharedPreference.getString(_userModelKey);
      // set the data into class of UserModel
      // 1 : 06 minutes
      userModel = UserModel.fromJson( jsonDecode(userData!) ); // jsonDecode mane String theke Map<> a convert kora
    }
}

// for checking User Login ase ki na !
static Future<bool> isUserLoggeIn() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String ? token = sharedPreferences.getString(_accessTokenKey);

     if(token != null){
      return true;
     }else{
       return false;
     }

}
// for logout
static Future clearUserData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // delete all data of User
   await sharedPreferences.clear();
}

}