import 'package:flutter/material.dart';

import '../../Data/Models/Task_Model.dart';
import '../../Data/Services/Api_Caller.dart';
import '../../Data/Utils/URLs.dart';
import '../Widgets/Snack_Bar.dart';
import '../Widgets/TMAppBar.dart';
import '../Widgets/Task_Card.dart';


// class CancelTaskScreen extends StatefulWidget {
//   const CancelTaskScreen({super.key});
//
//   @override
//   State<CancelTaskScreen> createState() => _CancelTaskScreenState();
// }
//
// class _CancelTaskScreenState extends State<CancelTaskScreen> {
//
//   List<TaskModel> _cancelledTaskList = [];
//   bool _isloading = false;
//
//   Future<void> getAllTasks()async {
//     _isloading = true;
//     setState(() {
//
//     });
//
//     ApiResponse response = await ApiCaller.getRequest(url: URLs.cancelledTaskUrl);
//
//     _isloading = false;
//     setState(() {
//
//     });
//     List<TaskModel> list = [];
//     if( response.isSuccess ){
//
//       for( Map<String, dynamic> jsonData in response.ResponseData['data']){
//         list.add(TaskModel.fromJson(jsonData));
//       }
//
//     }else{
//       showSnackBarMessage(context, response.errorMessage.toString());
//     }
//     _cancelledTaskList = list;
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getAllTasks();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: TMAppBar(),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: ListView.separated(
//           itemCount: _cancelledTaskList.length,
//           // For spacing between cards
//           separatorBuilder: (context, index){
//             return SizedBox(height: 5,);
//           },
//           itemBuilder: (context,index){
//             return TaskCard(
//               taskModel: _cancelledTaskList[index],
//               cardColor: Colors.blue,
//               refreshParent: (){
//                 getAllTasks();
//               },
//             );
//           },
//
//
//         ),
//       ),
//
//
//       // -------------------x-----------------------
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/UI/Widgets/TMAppBar.dart';
import 'package:task_manager/UI/Widgets/Task_Card.dart';

import '../../Data/Models/Task_Model.dart';
import '../../Data/Services/Api_Caller.dart';
import '../../Data/Utils/URLs.dart';
import '../../Providers/Task_Provider.dart';
import '../Widgets/Snack_Bar.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {


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

      taskProvider.fetchNewTaskByStatus('Cancelled')
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
                itemCount: taskProvider.cancelledTasks.length,
                // For spacing between cards
                separatorBuilder: (context, index){
                  return SizedBox(height: 5,);
                },
                itemBuilder: (context,index){
                  return TaskCard(
                    taskModel: taskProvider.cancelledTasks[index],
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
