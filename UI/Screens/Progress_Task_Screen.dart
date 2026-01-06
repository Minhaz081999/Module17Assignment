import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Data/Models/Task_Model.dart';
import '../../Data/Services/Api_Caller.dart';
import '../../Data/Utils/URLs.dart';
import '../../Providers/Task_Provider.dart';
import '../Widgets/Snack_Bar.dart';
import '../Widgets/TMAppBar.dart';
import '../Widgets/Task_Card.dart';


class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

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

      taskProvider.fetchNewTaskByStatus('Progress')
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
              itemCount: taskProvider.progressTasks.length,
              // For spacing between cards
              separatorBuilder: (context, index){
                return SizedBox(height: 5,);
              },
              itemBuilder: (context,index){
                return TaskCard(
                  taskModel: taskProvider.progressTasks[index],
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
