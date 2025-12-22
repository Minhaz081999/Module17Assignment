import 'package:flutter/material.dart';
// SVG package import
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/UI/Controller/Auth_Controller.dart';
import 'package:task_manager/UI/Screens/Login_Page.dart';
import 'package:task_manager/UI/Utils/AssetsPaths.dart';
import 'package:task_manager/UI/Widgets/Screen_Background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextscreen();
  }



  // The underscore _ protects the function so only this file can use it.
  Future<void> _moveToNextscreen() async{
    await Future.delayed(

      Duration(seconds: 5),

    );

   final bool isLoggedIn = await AuthController.isUserLoggeIn() ;
   // ekbar Login korle second time r Login kora lagbe na
    // automatic Home Page dekhabe
    if( isLoggedIn ){

     Navigator.pushReplacementNamed(context, '/MainNabbarHolderScreen');
   }else {
     Navigator.pushReplacement(
         context, MaterialPageRoute(builder: (context) => LoginPage()));
   }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
            child: SvgPicture.asset(AssetsPaths.penSVG)
        ),
      )



      //---------------------------x----------------------------
    );
  }
}
