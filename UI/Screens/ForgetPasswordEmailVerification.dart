import 'package:flutter/material.dart';
import 'package:task_manager/UI/Widgets/Screen_Background.dart';

import 'Forget_Password_Verify_OTP_Screen.dart';

class Forgetpasswordemailverification extends StatelessWidget {
  const Forgetpasswordemailverification({super.key});

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

                Text("Your Email Address",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // gap
                const SizedBox(height: 4,),

                Text("A 6 digits will be sent to your email address",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.green
                  ),
                ),

                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter your Email Address"
                  ),
                ),
                // gap
                const SizedBox(height:20),

                FilledButton(

                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordVerifyOtpScreen()));
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
