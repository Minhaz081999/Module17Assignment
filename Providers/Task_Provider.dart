import 'package:flutter/cupertino.dart';
import 'package:task_manager/Core/Api_State.dart';
import 'package:task_manager/Data/Models/Task_Status_Count_Model.dart';
import 'package:task_manager/Data/Services/Api_Caller.dart';
import 'package:task_manager/Data/Utils/URLs.dart';

import '../Data/Models/Task_Model.dart';

// class TaskProvider extends ChangeNotifier {
//
//   List<TaskModel> _newTasks = [];
//   List<TaskModel> _progressTasks = [];
//   List<TaskModel> _completedTasks = [];
//   List<TaskModel> _cancelledTasks = [];
//
//   List<TaskStatusCountModel> _taskStatusCount = [];
//
//   ApiState _taskListState = ApiState.initial;
//   ApiState _taskCountState = ApiState.initial;
//
//
//   String ? _errorMessage;
//
//   List<TaskModel> get newTasks => _newTasks;
//   List<TaskModel> get progressTasks => _progressTasks;
//   List<TaskModel> get completedTasks => _completedTasks;
//   List<TaskModel> get cancelledTasks => _cancelledTasks;
//   List<TaskStatusCountModel> get taskStatusCount => _taskStatusCount;
//
//   Future<void> fetchTaskStatusCount()async{
//     _taskCountState = ApiState.loading;
//     notifyListeners();
//
//     final ApiResponse response = await ApiCaller.getRequest(url: URLs.taskCountURL);
//
//     if(response.isSuccess){
//       _taskStatusCount = [];
//       for( Map<String, dynamic> jsonData in response.ResponseData['data']){
//         _taskStatusCount.add(TaskStatusCountModel.fromJson(jsonData));
//       }
//       _taskCountState = ApiState.success;
//       _errorMessage = null;
//     }else{
//       _taskCountState = ApiState.error;
//       _errorMessage = response.errorMessage ?? 'Failed to fetch task count';
//     }
//     notifyListeners();
//   }
//
// }
class TaskProvider extends ChangeNotifier{
  List<TaskModel> _newTasks = [];
  List<TaskModel> _progressTasks = [];
  List<TaskModel> _completedTasks = [];
  List<TaskModel> _cancelledTasks = [];

  List<TaskStatusCountModel> _taskStatusCount = [];

  ApiState _taskListState = ApiState.initial;
  ApiState _taskCountState = ApiState.initial;

  String ? _errorMessage;

  List<TaskModel> get newTasks => _newTasks;
  List<TaskModel> get progressTasks => _progressTasks;
  List<TaskModel> get completedTasks => _completedTasks;
  List<TaskModel> get cancelledTasks => _cancelledTasks;

  List<TaskStatusCountModel> get taskStatusCount => _taskStatusCount;


  Future<void> fetchTaskStatusCount()async {
    _taskCountState = ApiState.loading;
    notifyListeners();

    final ApiResponse response =
    await ApiCaller.getRequest(url: URLs.taskCountURL);

    if(response.isSuccess){
      _taskStatusCount = [];
      for (Map<String, dynamic> jsonData in response.ResponseData['data']) {
        _taskStatusCount.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskCountState = ApiState.success;
      _errorMessage = null;
    }else{

      _taskCountState = ApiState.error;
      _errorMessage = response.errorMessage ?? 'Failed to fetch task Count';

    }

    notifyListeners();

  }


  Future<void> fetchNewTaskByStatus(String status)async {
    _taskListState = ApiState.loading;
    notifyListeners();

    String url;

    switch(status){
      case ('New'):
        url = URLs.newTaskURL;
        break;
      case 'Progress' :
        url = URLs.progressTaskUrl;
        break;
      case 'Completed'  :
        url = URLs.completedTaskUrl;
        break;
      case 'Cancelled'  :
        url = URLs.cancelledTaskUrl;
        break;
      default:
        url = URLs.newTaskURL;
    }

    final ApiResponse response =
    await ApiCaller.getRequest(url: url);

    if(response.isSuccess){
      List<TaskModel> tasks = [];
      for (Map<String, dynamic> jsonData in response.ResponseData['data']) {
        tasks.add(TaskModel.fromJson(jsonData));
      }
      switch(status){
        case ('New'):
          _newTasks = tasks;
          break;
        case 'Progress' :
          _progressTasks = tasks;
          break;
        case 'Completed'  :
          _completedTasks = tasks;
          break;
        case 'Cancelled'  :
          _cancelledTasks = tasks;
          break;
        default:
          _newTasks = tasks;
      }


      _taskListState = ApiState.success;
      _errorMessage = null;
    }else{

      _taskCountState = ApiState.error;
      _errorMessage = response.errorMessage ?? 'Failed to fetch task';

    }

    notifyListeners();

  }

}