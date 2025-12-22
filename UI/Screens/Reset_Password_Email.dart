import 'package:flutter/material.dart';

import '../Widgets/Screen_Background.dart';
import 'Forget_Password_Verify_OTP_Screen.dart';

class ResetPasswordEmail extends StatefulWidget {
  const ResetPasswordEmail({super.key});

  @override
  State<ResetPasswordEmail> createState() => _ResetPasswordEmailState();
}

class _ResetPasswordEmailState extends State<ResetPasswordEmail> {
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

                Text("Set password",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // gap
                const SizedBox(height: 4,),

                Text("Password should be more then 6 characters and comnination of numbers",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.green
                  ),
                ),
                // gap
                const SizedBox(height: 4,),

                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Enter your password "
                  ),
                ),
                // gap
                const SizedBox(height: 4,),

                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Enter your password "
                  ),
                ),
                // gap
                const SizedBox(height:20),

                FilledButton(

                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>ForgetPasswordVerifyOtpScreen()));
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
