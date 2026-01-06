import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/Core/Api_State.dart';

import '../Data/Models/User_Model.dart';
// AuthProvidr = AuthController

class AuthProvider extends ChangeNotifier{

  String ? _accessToken;
  String ? _errorMessage;
  UserModel ? _userModel;
  static String _accessTokenKey = 'token';
  static String _userModelKey = 'user-data';

  ApiState _authState = ApiState.initial;

  String ? get accessToken => _accessToken;
  UserModel ? get userModel => _userModel;
  ApiState ? get authState  => _authState;
  String ? get errorMessage  => _errorMessage;
  bool get isLoggedIn => _accessToken != null;

  // for setting values in Local Memory (SharedPreferences)
  Future saveUserData( UserModel model, String token) async {
    // object create from Class of SharedPreference
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    _accessToken = token;
    await sharedPreference.setString(_accessTokenKey, token);

    _userModel = model;
    await sharedPreference.setString(
        _userModelKey,
        jsonEncode( model.toJson() ) // return convert Map<> to json String value
    );

    notifyListeners();

  }

  // for getting values from Local Memory (SharedPreferences)
   Future loadUserData () async{
    // object create
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String ? token = sharedPreference.getString(_accessTokenKey);

    if( token != null){
      _accessToken = token;
      // get the values from Local Memory (SharedPreferences)
      String ? userData = sharedPreference.getString(_userModelKey);
      // set the data into class of UserModel
      // 1 : 06 minutes
      _userModel = UserModel.fromJson( jsonDecode(userData!) ); // jsonDecode mane String theke Map<> a convert kora
    }

    notifyListeners();
  }

   Future<void> updateUserData(UserModel model) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userModelKey, jsonEncode(model.toJson));

    notifyListeners();
  }

// for checking User Login ase ki na !
  static Future<bool> checkLoginStatus() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String ? token = sharedPreferences.getString(_accessTokenKey);

    return token != null;

  }
// for logout
   Future logout() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // delete all data of User
    await sharedPreferences.clear();
    _accessToken = null;
    _userModel = null;
    _authState = ApiState.initial;

    notifyListeners();
  }

  void setLoading(){
    _authState = ApiState.loading;

    notifyListeners();
  }
  void setSuccess(){
    _authState = ApiState.success;

    notifyListeners();
  }
  void setError(){
    _authState = ApiState.error;

    notifyListeners();
  }
  void resetState(){
    _authState = ApiState.initial;
    _errorMessage = null;

    notifyListeners();
  }

}