import 'package:flutter/material.dart';
import 'package:task_manager/Data/Models/Task_Model.dart';

import '../../Data/Services/Api_Caller.dart';
import '../../Data/Utils/URLs.dart';
import 'Snack_Bar.dart';

class TaskCard extends StatefulWidget {

  final TaskModel taskModel;
  final Color cardColor;
  final VoidCallback refreshParent;

  const TaskCard({
    super.key, required this.taskModel, required this.cardColor, required this.refreshParent,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  bool _changeStatusInProgress = false;
  bool _deleteLoading = false;


  Future<void> _changeStatus( String status )async {
    _changeStatusInProgress = true;


    ApiResponse response = await ApiCaller.getRequest(
        url: URLs.changeStatus(widget.taskModel.id, status));

    _changeStatusInProgress = false;
    setState(() {

    });

    if( response.isSuccess ){

      widget.refreshParent;
      Navigator.pop(context);

    }else{
      showSnackBarMessage(context, response.errorMessage.toString());
    }

  }
  Future<void> deleteTask() async {
    _deleteLoading = true;
    setState(() {

    });
    final ApiResponse response =await ApiCaller.getRequest(url: URLs.deleteTaskUrl(widget.taskModel.id));
    _deleteLoading = false;
    setState(() {

    });
    if(response.isSuccess){
      widget.refreshParent();
      showSnackBarMessage(context, 'Task Deleted');
    }else{
      showSnackBarMessage(context, response.errorMessage.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    void _showChangeStatusDialog(){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text('Change Status'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: (){
                      _changeStatus('New');
                    },
                    title: Text('New'),
                    trailing: widget.taskModel.status == 'New' ? Icon(Icons.done) : null,
                  ),
                  ListTile(
                    onTap: (){
                      _changeStatus('Progress');
                    },
                    title: Text('Progress'),
                    trailing: widget.taskModel.status == 'Progress' ? Icon(Icons.done) : null,
                  ),
                  ListTile(
                    onTap: (){
                      _changeStatus('Cancelled');
                    },
                    title: Text('Cancelled'),
                    trailing: widget.taskModel.status == 'Cancelled' ? Icon(Icons.done) : null,
                  ),
                  ListTile(
                    onTap: (){
                      _changeStatus('Completed');
                    },
                    title: Text('Completed'),
                    trailing: widget.taskModel.status == 'Completed' ? Icon(Icons.done) : null,
                  ),
                ],
              ),
            );
          }
      );
    }
   


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
      child: Card(
        // For background COLOR
        color: Colors.grey.shade300,
        child: ListTile(
          shape: RoundedRectangleBorder(
              // side: BorderSide(
              //     color: Colors.black,
              //     width: 5,
              //     style: BorderStyle.solid
              // ),
             // borderRadius: BorderRadius.circular(10)
          ),
          title: Text(widget.taskModel.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 18
          ),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.taskModel.description),
              Text('Date : ${widget.taskModel.createdDate}'),
              Row(
                children: [
                  Chip(
                    backgroundColor: widget.cardColor,
                    label: Text(widget.taskModel.status),
                    labelStyle: TextStyle(color: Colors.white),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(25)
                    ),
                    // For Inner Paddding
                    padding: EdgeInsets.symmetric(horizontal: 30),
                  ),
                  // gap
                  Spacer(),
                  IconButton(
                      onPressed: (){
                        _showChangeStatusDialog();

                      },
                      icon: Icon(Icons.edit_note_rounded, color: Colors.green,)
                  ),
                  IconButton(
                      onPressed: (){
                        deleteTask();
                      },
                      icon: Icon(Icons.delete, color: Colors.red,)
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}