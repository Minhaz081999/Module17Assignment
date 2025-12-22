import 'package:flutter/material.dart';

import '../../Data/Models/Task_Model.dart';
import '../../Data/Services/Api_Caller.dart';
import '../../Data/Utils/URLs.dart';
import '../Widgets/Snack_Bar.dart';
import '../Widgets/TMAppBar.dart';
import '../Widgets/Task_Card.dart';


class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  List<TaskModel> _progressTaskList = [];
  bool _getprogressTaskProgress = false;
  Future<void> getAllTasks()async {
    _getprogressTaskProgress = true;
    setState(() {

    });

    ApiResponse response = await ApiCaller.getRequest(url: URLs.progressTaskUrl);

    _getprogressTaskProgress = false;
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
    _progressTaskList = list;
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
          visible: _getprogressTaskProgress == false,
          replacement: Center(child: CircularProgressIndicator()),
          child: ListView.separated(
            itemCount: _progressTaskList.length,
            // For spacing between cards
            separatorBuilder: (context, index){
              return SizedBox(height: 5,);
            },
            itemBuilder: (context,index){
              return TaskCard(
                taskModel: _progressTaskList[index],
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
