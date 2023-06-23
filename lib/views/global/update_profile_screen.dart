

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';
import 'package:gocar/controllers/user/profile_controller.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/widgets/loader_widget.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({ Key? key }) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final profilecontroller = Get.find<ProfileController>();
  final authcontroller = Get.find<AuthController>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController ;
  late TextEditingController _contactNumberController ;
  late TextEditingController _addressController ;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void initState() {

      if(authcontroller.user.value.uid != null){

firstNameController = TextEditingController(text: authcontroller.user.value.first_name);
lastNameController = TextEditingController(text: authcontroller.user.value.last_name);
_contactNumberController = TextEditingController(text: authcontroller.user.value.contact_number);

      }else{
  firstNameController = TextEditingController();
lastNameController = TextEditingController();
_contactNumberController =TextEditingController();
_addressController =TextEditingController();

      }
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    _contactNumberController.dispose();

    super.dispose();
  }

  void updateUserDetails(BuildContext context) {
    if (formKey.currentState!.validate()) {

        profilecontroller.updateUserDetails(context: context, firstName: firstNameController.text.trim(), lastName: lastNameController.text.trim(), contact_number: _contactNumberController.text.trim(), );
    
    }
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const  EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20.0),
                const Text(
                  'User Details',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
               const SizedBox(height: 20.0),
                TextFormField(
                  controller: firstNameController,
                  decoration:const  InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
               const SizedBox(height: 20.0),
                TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _contactNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter contact number';
                    }
                    return null;
                  },  
                ),
                
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Adrress',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20.0),
                GetBuilder<ProfileController>(
                  builder: (controller) {
                    return ElevatedButton(
                      onPressed: ()=> controller.isUpdating.value ? null: updateUserDetails(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:AppColor.primary,
                        foregroundColor: Colors.white, // Set the button color to your custom color
                      ),
                      child:controller.isUpdating.value ? Center(child: LoaderWidget(color: Colors.white,)) :  const Text('Update'),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}



