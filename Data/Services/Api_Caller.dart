import 'dart:convert';
// API's calling
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
// Error Detection from Logger Package
import 'package:logger/logger.dart';
import 'package:task_manager/UI/Controller/Auth_Controller.dart';
import 'package:task_manager/app.dart';

class ApiCaller{
  //------------ Error Detection ------------
  static final Logger _logger = Logger();

  static void _logRequest( String Url, {Map <String, dynamic> ? body } ){
   _logger.i(
     'URL => $Url\n'
     'Request Body => $body\n',

   );
  }
  static void _logResponse( String Url, Response response  ){
   _logger.i(
     'URL => $Url\n'
     'Status Code => ${response.statusCode}\n'
     'Request Body => ${response.body}\n',

   );
  }
  // for Unauthorize user ............................
  static Future<void> _movetoLogin() async{
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(TaskManagerApp.navigator.currentContext!, '/LoginPage', (route)=> false);
  }

 //---------------- GET Request -----------------
 static Future <ApiResponse> getRequest({required String url}) async {
  try{

    _logRequest(url);

    Uri uri = Uri.parse(url);
    Response response = await get(uri, headers: {
      'token' : AuthController.accessToken ?? ''
    });

    _logResponse(url, response);

    final int statusCode = response.statusCode;
    final decodedData = jsonDecode(response.body);
    if(statusCode == 200){


      return ApiResponse(ResponseCode: statusCode, ResponseData: decodedData, isSuccess: true );

    }else if( statusCode == 401){
     await _movetoLogin();
     return ApiResponse(
         ResponseCode: -1,
         ResponseData: null,
         isSuccess: false);
    }
    else{
      return ApiResponse(ResponseCode: statusCode, ResponseData: decodedData, isSuccess: false );
    }

  }catch(e){
    return ApiResponse(ResponseCode: -1, ResponseData: null, isSuccess: false, errorMessage:  e.toString() );
  }
 }

 //---------------- POST Request -----------------
 static Future <ApiResponse> postRequest({required String url, Map <String, dynamic> ? body }) async {
  try{

    _logRequest(url,body: body);

    Uri uri = Uri.parse(url);
    Response response = await post(uri,
    headers: {
      'Accept' : 'application/json',
      'Content-Type' : 'application/json',
      'token' : AuthController.accessToken ?? ''
    },
    body: body != null
        ?
        jsonEncode(body)
        :
        null,
    );

    _logResponse(url, response);

    final int statusCode = response.statusCode;
    final decodedData = jsonDecode(response.body);
    if(statusCode == 200 || statusCode == 201){


      return ApiResponse(ResponseCode: statusCode, ResponseData: decodedData, isSuccess: true );

    }else if (statusCode == 401){
       await _movetoLogin();
       return ApiResponse(
           ResponseCode: -1,
           ResponseData: null,
           isSuccess: false);

    }else{
      return ApiResponse(ResponseCode: statusCode, ResponseData: decodedData, isSuccess: false );
    }

  }catch(e){
    return ApiResponse(ResponseCode: -1, ResponseData: null, isSuccess: false, errorMessage:  e.toString() );
  }
 }

// ---------------x-------------------
}

class ApiResponse{

  final int ResponseCode;
  final dynamic ResponseData;
  final bool isSuccess;
  final String ? errorMessage;


  ApiResponse( { required this.ResponseCode, required this.ResponseData, required this.isSuccess, this.errorMessage ='Something Wrong' });


}