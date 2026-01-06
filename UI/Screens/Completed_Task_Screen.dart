import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/UI/Widgets/TMAppBar.dart';
import 'package:task_manager/UI/Widgets/Task_Card.dart';

import '../../Data/Models/Task_Model.dart';
import '../../Data/Services/Api_Caller.dart';
import '../../Data/Utils/URLs.dart';
import '../../Providers/Task_Provider.dart';
import '../Widgets/Snack_Bar.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // “Flutter,
    // finish creating the screen FIRST,
    // then I’ll change the data.
    Future.microtask((){
      loadData();
    });
  }
  Future<void> loadData()async{
    final taskProvider = Provider.of<TaskProvider>(context,listen: false);
    Future.wait([

      taskProvider.fetchNewTaskByStatus('Completed')
    ]);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.separated(
              itemCount: taskProvider.completedTasks.length,
              // For spacing between cards
              separatorBuilder: (context, index){
                return SizedBox(height: 5,);
              },
              itemBuilder: (context,index){
                return TaskCard(
                  taskModel: taskProvider.completedTasks[index],
                  cardColor: Colors.blue,
                  refreshParent: (){
                    loadData();
                  },
                );
              },


            ),
          );
        }
      ),


     // -------------------x-----------------------
    );
  }
}
