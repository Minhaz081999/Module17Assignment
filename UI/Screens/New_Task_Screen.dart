import 'package:flutter/material.dart';
import 'package:task_manager/Data/Models/Task_Model.dart';
import 'package:task_manager/Data/Models/Task_Status_Count_Model.dart';
import 'package:task_manager/Data/Services/Api_Caller.dart';
import 'package:task_manager/Data/Utils/URLs.dart';
import 'package:task_manager/UI/Screens/Add_New_Task_Screen.dart';
import 'package:task_manager/UI/Widgets/Snack_Bar.dart';

import '../Widgets/TMAppBar.dart';
import '../Widgets/Task_Card.dart';
import '../Widgets/Task_Count_By_Status.dart';


class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  bool _getTaskStatusCountProgress = false;
  bool _getNewTaskProgress = false;

  List<TaskStatusCountModel>_taskStatusCountList = [];
  List<TaskModel> _newTaskList = [];

  Future<void> getAllTaskCount()async {
    _getTaskStatusCountProgress = true;
    setState(() {

    });

    ApiResponse response = await ApiCaller.getRequest(url: URLs.taskCountURL);

    _getTaskStatusCountProgress = false;
    setState(() {

    });
    List<TaskStatusCountModel> list = [];
    if( response.isSuccess ){

      for( Map<String, dynamic> jsonData in response.ResponseData['data']){
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      
    }else{
      showSnackBarMessage(context, response.errorMessage.toString());
    }
    _taskStatusCountList = list;
  }
  Future<void> getAllNewTasks()async {
    _getNewTaskProgress = true;
    setState(() {

    });

    ApiResponse response = await ApiCaller.getRequest(url: URLs.newTaskURL);

    _getNewTaskProgress = false;
    setState(() {

    });
    List<TaskModel> list = [];
    if( response.isSuccess ){

      for( Map<String, dynamic> jsonData in response.ResponseData['data']){
        list.add(TaskModel.fromJson(jsonData));
      }

    }else{
      showSnackBarMessage(context, response.errorMessage.toString());
    }
    _newTaskList = list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTaskCount();
    getAllNewTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: TMAppBar(),
      body: Column(
        children: [
          //gap
          SizedBox(height: 15,),
          // SixedBox,Expanded,Container er vitore ListView hobe .....................
          // time -> 1:27
          // Row borabor Listview............................................
          SizedBox(
            height: 90,
            child: Visibility(
              visible: _getTaskStatusCountProgress == false,
              replacement: Center(child: CircularProgressIndicator()),
              child: ListView.separated(
                  scrollDirection : Axis.horizontal,
              
                  itemCount: _taskStatusCountList.length,
                  // For spacing between cards
                  separatorBuilder: (context, index){
                  return SizedBox(width: 30,);
                  },
              
                  itemBuilder: (context,index){
                    return TaskCountByStatus(
                      title: _taskStatusCountList[index].status,
                      count: _taskStatusCountList[index].count,
                    );
                  }
              
              ),
            ),
          ),

         // Column borabor Listview ............................................
          Expanded(
            child: Visibility(
              visible: _getNewTaskProgress == false,
              replacement: Center(child: CircularProgressIndicator()),
              child: ListView.separated(
                itemCount: _newTaskList.length,
                // For spacing between cards
                separatorBuilder: (context, index){
                  return SizedBox(height: 5,);
                },
                itemBuilder: (context,index){
                  return TaskCard(
                    taskModel: _newTaskList[index],
                    cardColor: Colors.blue,
                    // force to refresh page
                    refreshParent: (){
                      getAllTaskCount();
                      getAllNewTasks();

                    },
                  );
                },


              ),
            ),
          )
          
        ],
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





