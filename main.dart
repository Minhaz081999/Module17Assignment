import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Providers/Auth_Provider.dart';
import 'package:task_manager/app.dart';

import 'Providers/Network_Provider.dart';
import 'Providers/Task_Provider.dart';

void main (){

// runApp(TaskManagerApp());
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> AuthProvider()),
      ChangeNotifierProvider(create: (_)=> NetworkProvider()),
      ChangeNotifierProvider(create: (_)=> TaskProvider()),

    ],
      child: TaskManagerApp(),
    ),
  );

// ----------------------x-----------------------
}