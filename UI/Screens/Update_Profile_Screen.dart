import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager/UI/Widgets/Screen_Background.dart';
import 'package:task_manager/UI/Widgets/Snack_Bar.dart';
import 'package:task_manager/UI/Widgets/TMAppBar.dart';
// Image_Picker
import 'package:image_picker/image_picker.dart';

import '../../Data/Models/User_Model.dart';
import '../../Data/Services/Api_Caller.dart';
import '../../Data/Utils/URLs.dart';
import '../Controller/Auth_Controller.dart';
import '../Widgets/Photo_Picker.dart';
import 'Main_NabBar_Holder_Screen.dart';


class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    UserModel model = AuthController.userModel!;
    _emailController.text = model.email;
    _firstnameController.text = model.firstName;
    _lastnameController.text = model.lastName;
    _mobileController.text = model.mobile;

  }

  // Photo pick kore gallery theke
  ImagePicker _imagePicker = ImagePicker();
  // Photo File hold kore rakhe
  XFile ? _selectedImage ;

  Future <void> _pickImage()async {
    // Photo File hold kore rakhe
    XFile ? image = await _imagePicker.pickImage(source: ImageSource.camera);

    if (image != null ){
      setState(() {
        _selectedImage = image;
      });

    }

  }
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: "Email"
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your email';
                        }
                        return null;
                      },
                    ),
                    // gap
                    const SizedBox(height: 4,),

                    TextFormField(
                      controller: _firstnameController,
                      decoration: InputDecoration(
                          hintText: "First Name "
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                    ),
                    // gap
                    const SizedBox(height: 4,),
                    TextFormField(
                      controller: _lastnameController,
                      decoration: InputDecoration(
                          hintText: "Last Name "
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your last name';
                        }
                        return null;
                      },
                    ),
                    // gap
                    const SizedBox(height: 4,),

                    TextFormField(
                      controller: _mobileController,
                      decoration: InputDecoration(
                          hintText: "Mobile Number "
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your mobile';
                        }
                        return null;
                      },
                    ),
                    // gap
                    const SizedBox(height: 4,),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: "Enter your password "
                      ),
                      validator: (String? value) {
                        if ((value != null && value.isNotEmpty) && value.length < 6) {
                          return 'Enter a password more than 6 letters';
                        }

                        return null;
                      },
                    ),
                    // gap
                    const SizedBox(height: 4,),
                    // gap
                    const SizedBox(height:20),

                    FilledButton(

                        onPressed: (){
                          if( _formKey.currentState!.validate() ){
                            updateProfile();

                          }
                         },

                        child: Icon(Icons.arrow_circle_right_outlined)
                    ),
                    // gap
                    const SizedBox(height:20),




                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
  bool isLoading = false;
  Future<void> updateProfile() async{
    isLoading = true;
    //for reload page
    setState(() {

    });
    Map< String, dynamic >requestBody ={
      "email":_emailController.text,
      "firstName":_firstnameController.text,
      "lastName":_lastnameController.text,
      "mobile":_mobileController.text,

    };
    if(_passwordController.text.isNotEmpty){
      requestBody['password'] = _passwordController.text;
    }
    // FOR IMAGE -- Real Image convert to Bytes
    String ? encodedPhoto;
    if( _selectedImage != null ){
      // Real Image convert to Bytes
      List<int> bytes = await _selectedImage!.readAsBytes();
      // Convert from Bytes to JsonString
      encodedPhoto = jsonEncode(bytes);
      requestBody['photo'] = encodedPhoto;

      final ApiResponse response =  await ApiCaller.postRequest(
                                                      url: URLs.updateProfileUrl,
                                                      body: requestBody
                                                      );


      isLoading = false;
      // for reload page
      setState(() {

      });
      if(response.isSuccess){
        print(response.ResponseData['data']);
        UserModel model =  UserModel(
          id: AuthController.userModel!.id,
          email:  _emailController.text,
          firstName: _firstnameController.text,
          lastName: _lastnameController.text,
          mobile: _mobileController.text,
          photo: encodedPhoto ?? AuthController.userModel!.photo,
        );

        AuthController.updateUserData(model);
        showSnackBarMessage(context, 'Profile Updated');
      }else{
        showSnackBarMessage(context, response.errorMessage!);
      }

    }


  }

  //-------------------- x --------------------------
}


