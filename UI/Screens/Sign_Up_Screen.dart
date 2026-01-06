import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Data/Services/Api_Caller.dart';

import '../../Data/Utils/URLs.dart';
import '../../Providers/Network_Provider.dart';
import '../Widgets/Screen_Background.dart';
import 'Forget_Password_Verify_OTP_Screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  // variable nibo
 final TextEditingController _emailController = TextEditingController();
 final TextEditingController _firstnameController = TextEditingController();
 final TextEditingController _lastnameController = TextEditingController();
 final TextEditingController _mobilenumberController = TextEditingController();
 final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  bool signupProgress = false;

  Future <void> _signup() async{
    final networkProvider = Provider.of<NetworkProvider>(context,listen: false);
    final result = networkProvider.register(
        email: _emailController.text.trim(),
        firstName: _firstnameController.text.trim(),
        lastName: _lastnameController.text.trim(),
        mobile: _mobilenumberController.text.trim(),
        password: _passwordController.text.trim());
      //new user can only register one time.....................................
      if( result != null){

        _clearTextField();
        ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Sign up or Register success.....'),
         backgroundColor: Colors.green,
           duration: Duration( seconds: 5 ),
         )
        );
        Navigator.pop(context);
      }
      // old user can't register multiple time with same value.................
      else{

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(networkProvider.errorMessage ?? 'Something wrong'),
              backgroundColor: Colors.red,
              duration: Duration( seconds: 5 ),
            )
        );
      }

  }

  _clearTextField(){

    _emailController.clear();
    _firstnameController.clear();
    _lastnameController.clear();
    _mobilenumberController.clear();
    _passwordController.clear();

  }
  // Clear the memory of TextField .........................................
  @override
  void dispose() {
    _emailController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _mobilenumberController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();

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

                    Text("Join With Us",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    // gap
                    const SizedBox(height: 4,),
                    // gap
                    const SizedBox(height: 4,),

                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: "Email"
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
                    const SizedBox(height: 4,),

                    TextFormField(
                      controller: _firstnameController,
                      decoration: InputDecoration(
                          hintText: "First Name "
                      ),
                      // Checking Textfield error ...................
                      validator: (String ? value){

                        if( value == null || value.isEmpty){
                          return 'Please enter your first name';
                        }
                        if( value.trim().length <= 2 ){
                          return 'Characters at least more than 2 lengths';
                        }

                        // Everything Okay
                        return null ;
                      },
                    ),
                    // gap
                    const SizedBox(height: 4,),
                    TextFormField(
                      controller: _lastnameController,
                      decoration: InputDecoration(
                          hintText: "Last Name "
                      ),
                      // Checking Textfield error ...................
                      validator: (String ? value){

                        if( value == null || value.isEmpty){
                          return 'Please enter your last name';
                        }
                        if( value.trim().length <= 2 ){
                          return 'Characters at least more than 2 lengths';
                        }

                        // Everything Okay
                        return null ;
                      },
                    ),
                    // gap
                    const SizedBox(height: 4,),

                    TextFormField(
                      controller: _mobilenumberController,
                      decoration: InputDecoration(
                          hintText: "Mobile Number "
                      ),
                      // Checking TextFIELD error .............................
                      validator: (String ? value ){

                        if( value == null || value.isEmpty ){
                          return 'enter your phone number';
                        }
                        if( value.trim().length != 11 ){
                          return 'Enter valid phone number';
                        }
                        // Everything Okay
                        return null ;
                      },
                    ),
                    // gap
                    const SizedBox(height: 4,),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: "Enter your password "
                      ),
                      // Checking TextField Error .............................
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
                    const SizedBox(height: 4,),
                    // gap
                    const SizedBox(height:20),

                    Visibility(
                      visible: !signupProgress,
                      replacement: Center(child: CircularProgressIndicator()),

                      child: FilledButton(

                          onPressed: (){
                            if( _formKey.currentState!.validate() ){

                              _signup();

                              // Move to Next Page
                              // Navigator.push(context, MaterialPageRoute(
                              //     builder: (context)=>ForgetPasswordVerifyOtpScreen()));

                            }

                          },
                          child: Icon(Icons.arrow_circle_right_outlined)
                      ),
                    ),
                    // gap
                    const SizedBox(height:20),

                    Center(
                      child: Column(
                        children: [

                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                              text: "Already have an account? ",
                              children: [
                                TextSpan(
                                    text: "Sign in",
                                    style: TextStyle(color: Colors.green)

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
          )
      ),



      // ---------------x-----------------
    );
  }
}
