import 'package:flutter/material.dart';
import 'package:task_manager/UI/Widgets/Screen_Background.dart';
import 'package:task_manager/UI/Widgets/TMAppBar.dart';
// Image_Picker
import 'package:image_picker/image_picker.dart';

import '../Widgets/Photo_Picker.dart';


class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  // Photo pick kore gallery theke
  ImagePicker _imagePicker = ImagePicker();
  // Photo File hold kore rakhe
  XFile ? _selectedImage ;

  Future <void> _pickImage()async {

    XFile ? image = await _imagePicker.pickImage(source: ImageSource.camera);

    if (image != null ){
      setState(() {
        _selectedImage = image;
      });

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // gap
                  const SizedBox(height: 50,),

                  Text("Update Profile",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  // gap
                  const SizedBox(height: 4,),

                  photo_picker(onTap: () {
                    _pickImage();
                  },
                    selectedPhoto: _selectedImage,),

                  // gap
                  const SizedBox(height: 4,),

                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Email"
                    ),
                  ),
                  // gap
                  const SizedBox(height: 4,),

                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "First Name "
                    ),
                  ),
                  // gap
                  const SizedBox(height: 4,),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Last Name "
                    ),
                  ),
                  // gap
                  const SizedBox(height: 4,),

                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Mobile Number "
                    ),
                  ),
                  // gap
                  const SizedBox(height: 4,),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Enter your password "
                    ),
                  ),
                  // gap
                  const SizedBox(height: 4,),
                  // gap
                  const SizedBox(height:20),

                  FilledButton(

                      onPressed: (){

                       },

                      child: Icon(Icons.arrow_circle_right_outlined)
                  ),
                  // gap
                  const SizedBox(height:20),




                ],
              ),
            ),
          )
      ),
    );
  }
}


