import 'package:flutter/material.dart';
import 'package:task_manager/Data/Models/User_Model.dart';
import 'package:task_manager/Data/Services/Api_Caller.dart';
import 'package:task_manager/UI/Controller/Auth_Controller.dart';
import 'package:task_manager/UI/Widgets/Screen_Background.dart';
import 'package:task_manager/UI/Widgets/TMAppBar.dart';

import '../../Data/Utils/URLs.dart';
import '../Widgets/Snack_Bar.dart';


class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {


  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey< FormState > _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100,),
                  Text('Add new task',
                  style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Title'
                    ),
                    // Checking Textfield error ...................
                    validator: (String ? value){

                      if( value == null || value.isEmpty){
                        return 'Please enter your task title';
                      }

                      // Everything Okay
                      return null ;
                    },
                  ),
                  const SizedBox(height: 25,),
                  TextFormField(
                    maxLines: 6,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Description'
                    ),
                    // Checking Textfield error ...................
                    validator: (String ? value){

                      if( value == null || value.isEmpty){
                        return 'Please enter your description';
                      }

                      // Everything Okay
                      return null ;
                    },
                  ),
                  const SizedBox(height: 25,),
                  FilledButton(
                      onPressed: (){
                        if( _formkey.currentState!.validate() ){
                          addNewTask();
                        }
                      },
                      child: Icon(Icons.arrow_circle_right_outlined)
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
  // Loading close
  bool _addTaskProgress = false;
  Future<void> addNewTask() async{

    // ------------- Loading running ----------
    _addTaskProgress = true;
    setState(() {

    });
    Map<String, dynamic> requestBody ={
      'title' : titleController.text,
      'description' : descriptionController.text,
      'status' : 'New'
    };
    // put data and get response
    ApiResponse response = await ApiCaller.postRequest(
        url: URLs.createTaskURL,
        body: requestBody
    );
    // --------- Loading close --------
    _addTaskProgress = false;
    setState(() {

    });

    // for clearing all TextFormField
    _clearField(){
      titleController.clear();
      descriptionController.clear();
    }
    if( response.isSuccess ){
      _clearField();
      Navigator.pushNamedAndRemoveUntil(context, '/MainNabbarHolderScreen', (route)=>false);
      showSnackBarMessage( context, 'New Task Added');
    }else{
      showSnackBarMessage( context, response.errorMessage! );
    }

  }


}
