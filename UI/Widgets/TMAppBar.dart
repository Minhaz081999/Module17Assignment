import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Data/Models/User_Model.dart';
import 'package:task_manager/Providers/Auth_Provider.dart';
import 'package:task_manager/UI/Controller/Auth_Controller.dart';
import 'package:task_manager/UI/Screens/Update_Profile_Screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
  });


  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {

 final  authProvider = Provider.of<AuthProvider>(context);
 final userModel = authProvider.userModel;
 final profilePhoto = userModel!.photo ?? '';

 String name = userModel.firstName;
 String email = userModel.email;

    return AppBar(
      backgroundColor: Colors.green,
      title: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=>UpdateProfileScreen()
            )
          );
        },
        child: Row(
          children: [
            CircleAvatar(
              child: profilePhoto.isNotEmpty ? Image.memory(jsonDecode(profilePhoto)) : Icon(Icons.person),
            ),
            SizedBox(width: 4,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white
                    )),
                SizedBox(width: 4,),
                Text(email,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white
                    )),
              ],
            )
          ],
        ),
      ),
      actions: [
        IconButton(onPressed: (){

          authProvider.logout();
          // “Go to Login Page and forget all old pages.”
          Navigator.pushNamedAndRemoveUntil(
              context,
              '/LoginPage',
              (route) => false // forget all old pages.”
          );
        }, icon: Icon(Icons.logout))
      ],
    );
  }


}


