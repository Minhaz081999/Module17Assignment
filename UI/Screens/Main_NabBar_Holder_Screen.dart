import 'package:flutter/material.dart';
import 'package:task_manager/UI/Screens/Cancel_Task_Screen.dart';
import 'package:task_manager/UI/Screens/Completed_Task_Screen.dart';
import 'package:task_manager/UI/Screens/New_Task_Screen.dart';
import 'package:task_manager/UI/Screens/Progress_Task_Screen.dart';

class MainNabbarHolderScreen extends StatefulWidget {
  const MainNabbarHolderScreen({super.key});

  @override
  State<MainNabbarHolderScreen> createState() => _MainNabbarHolderScreenState();
}

class _MainNabbarHolderScreenState extends State<MainNabbarHolderScreen> {

  int _selectedIndex = 0;

  // j koyta page load hobe
  List<Widget> _screens = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelTaskScreen(),

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _screens[_selectedIndex],

      bottomNavigationBar: NavigationBar(
          selectedIndex:_selectedIndex,
          onDestinationSelected : (int index){
            // Reload Page
            setState(() {
              _selectedIndex = index;
            });
          },

          destinations: [
            NavigationDestination(icon: Icon(Icons.document_scanner), label: 'New'),
            NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
            NavigationDestination(icon: Icon(Icons.done_all), label: 'Completed'),
            NavigationDestination(icon: Icon(Icons.cancel), label: 'Cancel'),

      ]),
    );
  }
}
