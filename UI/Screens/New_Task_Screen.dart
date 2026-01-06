import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Data/Models/Task_Model.dart';
import 'package:task_manager/Data/Models/Task_Status_Count_Model.dart';
import 'package:task_manager/Data/Models/User_Model.dart';
import 'package:task_manager/Data/Services/Api_Caller.dart';
import 'package:task_manager/Data/Utils/URLs.dart';
import 'package:task_manager/UI/Controller/Auth_Controller.dart';
import 'package:task_manager/UI/Screens/Add_New_Task_Screen.dart';
import 'package:task_manager/UI/Widgets/Snack_Bar.dart';

import '../../Providers/Task_Provider.dart';
import '../Widgets/TMAppBar.dart';
import '../Widgets/Task_Card.dart';
import '../Widgets/Task_Count_By_Status.dart';


class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {




Future<void> loadData()async{
  final taskProvider = Provider.of<TaskProvider>(context,listen: false);
  Future.wait([
  taskProvider.fetchTaskStatusCount(),
  taskProvider.fetchNewTaskByStatus('New')
  ]);

}

 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadData();
    // “Flutter,
    // finish creating the screen FIRST,
    // then I’ll change the data.
    Future.microtask((){
      loadData();
    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: TMAppBar(),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return Column(
            children: [
              //gap
              SizedBox(height: 15,),
              // SixedBox,Expanded,Container er vitore ListView hobe .....................
              // time -> 1:27
              // Row borabor Listview............................................
              SizedBox(
                height: 90,
                child: ListView.separated(
                    scrollDirection : Axis.horizontal,

                    itemCount: taskProvider.taskStatusCount.length,
                    // For spacing between cards
                    separatorBuilder: (context, index){
                    return SizedBox(width: 30,);
                    },

                    itemBuilder: (context,index){
                      final counts = taskProvider.taskStatusCount;
                      return TaskCountByStatus(
                        title: counts[index].status ,
                        count: counts[index].count ,
                      );
                    }

                ),
              ),

             // Column borabor Listview ............................................
              Expanded(
                child: ListView.separated(
                  itemCount: taskProvider.newTasks.length,
                  // For spacing between cards
                  separatorBuilder: (context, index){
                    return SizedBox(height: 5,);
                  },
                  itemBuilder: (context,index){
                    return TaskCard(
                      taskModel: taskProvider.newTasks[index],
                      cardColor: Colors.blue,
                      // force to refresh page
                      refreshParent: ()async{

                        await loadData();

                      },
                    );
                  },


                ),
              )

            ],
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>AddNewTaskScreen()
                )
            );
          },
          child: Icon(Icons.add),
      ),
    );
  }
}





