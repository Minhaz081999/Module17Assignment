import 'package:flutter/material.dart';
import 'package:task_manager/UI/Widgets/TMAppBar.dart';
import 'package:task_manager/UI/Widgets/Task_Card.dart';

import '../../Data/Models/Task_Model.dart';
import '../../Data/Services/Api_Caller.dart';
import '../../Data/Utils/URLs.dart';
import '../Widgets/Snack_Bar.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  List<TaskModel> _completedTaskList = [];
  bool _isloading = false;

  Future<void> getAllTasks()async {
    _isloading = true;
    setState(() {

    });

    ApiResponse response = await ApiCaller.getRequest(url: URLs.completedTaskUrl);

    _isloading = false;
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
    _completedTaskList = list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Visibility(
          visible: _isloading == false,
          replacement: Center(child: CircularProgressIndicator()),
          child: ListView.separated(
            itemCount: _completedTaskList.length,
            // For spacing between cards
            separatorBuilder: (context, index){
              return SizedBox(height: 5,);
            },
            itemBuilder: (context,index){
              return TaskCard(
                taskModel: _completedTaskList[index],
                cardColor: Colors.blue,
                refreshParent: (){
                  getAllTasks();
                },
              );
            },


          ),
        ),
      ),


     // -------------------x-----------------------
    );
  }
}
