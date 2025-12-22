import 'package:flutter/material.dart';
import 'package:task_manager/UI/Screens/Login_Page.dart';
import 'package:task_manager/UI/Screens/Main_NabBar_Holder_Screen.dart';
import 'package:task_manager/UI/Screens/Sign_Up_Screen.dart';
import 'package:task_manager/UI/Screens/Update_Profile_Screen.dart';

import 'UI/Screens/Splash_Screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});
  static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        // Text Theme
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600
          )
        ),
        // Textfield theme
        inputDecorationTheme: InputDecorationTheme(
          // background color
            fillColor: Colors.white,
            filled: true,


            hintStyle: TextStyle(color: Colors.grey),

            border: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none
            )
        ),
        // FillButton Theme
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green,
            fixedSize: Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),

          )
        )
      ),
      home: SplashScreen(),
      initialRoute: '/SplashScreen',
      routes: {
        '/SplashScreen' : (_)=> SplashScreen(),
        '/LoginPage' : (_)=> LoginPage(),
        '/SignUpScreen' : (_)=> SignUpScreen(),
        '/MainNabbarHolderScreen' : (_)=> MainNabbarHolderScreen(),
        '/UpdateProfileScreen' : (_)=> UpdateProfileScreen(),

      },


    );
  }
}
