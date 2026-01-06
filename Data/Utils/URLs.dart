class URLs{
//http://35.73.30.144:2005/api/v1
  static String _baseURL = 'http://35.73.30.144:2005/api/v1';
  static String registrationURL = '${_baseURL}/registration';
  static String loginURL = '${_baseURL}/login';
  static String createTaskURL = '${_baseURL}/createTask';
  static String taskCountURL = '${_baseURL}/taskStatusCount';
  static String newTaskURL = '${_baseURL}/listTaskByStatus/New';
  static String taskListURL(String type) => '${_baseURL}/listTaskByStatus/${type}';
  static String changeStatus(String taskId,String status) => '$_baseURL/updateTaskStatus/$taskId/$status';
  static String progressTaskUrl = '$_baseURL/listTaskByStatus/Progress';
  static String completedTaskUrl = '$_baseURL/listTaskByStatus/Completed';
  static String cancelledTaskUrl = '$_baseURL/listTaskByStatus/Cancelled';
  static String updateProfileUrl = '$_baseURL/profileUpdate';



  static String deleteTaskUrl(String taskId) => '$_baseURL/deleteTask/$taskId';

}