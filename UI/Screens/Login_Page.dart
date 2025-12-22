import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Data/Models/User_Model.dart';
import 'package:task_manager/UI/Controller/Auth_Controller.dart';
import 'package:task_manager/UI/Screens/ForgetPasswordEmailVerification.dart';
import 'package:task_manager/UI/Screens/Main_NabBar_Holder_Screen.dart';
import 'package:task_manager/UI/Screens/Sign_Up_Screen.dart';
import 'package:task_manager/UI/Widgets/Screen_Background.dart';

import '../../Data/Services/Api_Caller.dart';
import '../../Data/Utils/URLs.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool signinProgress = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  void _onTabForgetPassword(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgetpasswordemailverification()));
  }
  void _onTabSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // gap
                  const SizedBox(height: 82,),

                  Text("Get started with",
                  style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(

                      hintText: "Enter your email",

                    ),
                    // Checking TextField Error...............................
                    validator: (String ? value){

                      if( value == null || value.isEmpty ){
                        return 'Please enter email';
                      }

                      final emailRegExp = RegExp(  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      // emailRegExp.hasMatch(value) = false
                      // ! false = true

                      if( !emailRegExp.hasMatch(value) ){
                        return 'Please enter valid email';

                      }

                      // Everything okay
                      return null;

                    },

                  ),
                  // gap
                  const SizedBox(height:20),

                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(

                      hintText: "Enter your password",

                    ),
                    validator: (String ? value){
                      if( value == null || value.isEmpty ){
                        return 'Please enter your password';
                      }
                      if(value.length <= 6 ){
                        return 'Characters will be more than 6 length';
                      }
                      // Everything Okay
                      return null ;
                    },

                  ),
                  // gap
                  const SizedBox(height:20),


                  FilledButton(

                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                              _signin();

                          }

                        },
                        child: Icon(Icons.arrow_circle_right_outlined)
                    ),

                    const SizedBox(height: 30,),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: (){
                              _onTabForgetPassword();
                            },
                            child: Text("Forget Password")
                        ),

                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                            text: "Don't have an account? ",
                            children: [
                              TextSpan(
                                  text: "Sign up",
                                  style: TextStyle(color: Colors.green),
                                  recognizer: TapGestureRecognizer()..onTap = _onTabSignUp

                              )
                            ],

                          ),


                        )
                      ],
                    ),
                  ),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future <void> _signin() async{

    setState(() {
      signinProgress = true;
    });

    // Reload PAGE ...........................................................
    // TIME -> 58 MINUTES

    Map<String,dynamic>requestBody = {
      "email":_emailController.text,

      "password":_passwordController.text,
    };

    final ApiResponse response = await ApiCaller.postRequest(
        url: URLs.loginURL,
        body: requestBody
    );
    setState(() {
      signinProgress = false;
    });
    //new user can only register one time.....................................
    if( response.isSuccess){
      // API's data set into class of UserModel
      // convert from json to object
      UserModel model = UserModel.fromJson( response.ResponseData['data'] );
      String accessToken = response.ResponseData['token'];
      // save or set the data into class of AuthController
      await AuthController.saveUserData(model, accessToken);

      _clearTextField();

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign in or Login success.....'),
            backgroundColor: Colors.green,
            duration: Duration( seconds: 5 ),
          ),

      );
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=> MainNabbarHolderScreen())
      );

    }
    // old user can't register multiple time with same value.................
    else{

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.ResponseData['data']),
            backgroundColor: Colors.red,
            duration: Duration( seconds: 5 ),
          )
      );
    }

  }

  _clearTextField(){

    _emailController.clear();

    _passwordController.clear();

  }
  // Clear the memory of TextField .........................................
  @override
  void dispose() {
    _emailController.dispose();

    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();

  }
}
