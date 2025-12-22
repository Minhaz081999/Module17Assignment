import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/UI/Screens/Reset_Password_Email.dart';
import 'package:task_manager/UI/Widgets/Screen_Background.dart';


class ForgetPasswordVerifyOtpScreen extends StatelessWidget {
  const ForgetPasswordVerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // gap
                const SizedBox(height: 82,),

                Text("PIN verification",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // gap
                const SizedBox(height: 4,),

                Text("A 6 digits OTP will be sent to your email address",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.green
                  ),
                ),

                PinCodeTextField(

                  length: 6,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    inactiveColor: Colors.grey,
                    selectedColor: Colors.green,
                    selectedFillColor: Colors.white
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,



                  appContext: context,
                ),
                // gap
                const SizedBox(height:20),

                FilledButton(

                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>ResetPasswordEmail()
                      )
                      );
                    },
                    child: Icon(Icons.arrow_circle_right_outlined)
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
          )
      ),



      // ---------------x-----------------
    );
  }
}
