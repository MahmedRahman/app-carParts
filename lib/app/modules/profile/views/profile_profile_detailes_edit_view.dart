import 'package:carpart/app/data/component/CustomImageCached.dart';
import 'package:carpart/app/data/component/custemImgePicker/CustemImagePicker.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDetailesEditView extends GetView {
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حسابى'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              profileController.setProfile();
            },
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            dense: true,
            title: Text(
              'البيانات الشخصية',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
       
          CustemImagePicker(
            showimagepath:KUserImage.value,
            onclick: (value) {
              profileController.imagelogo = value;
            },
          ),
          ListTile(
            dense: true,
            title: Text('الاسم الشخصى'),
            subtitle: TextFormField(
              controller: profileController.nameText,
              //  initialValue: 'KName',
            ),
          ),
          ListTile(
            dense: true,
            title: Text('البريد الالكترونى'),
            subtitle: TextFormField(
              controller: profileController.emailText,
            ),
          ),

              ListTile(
            dense: true,
            title: Text('ألمدينة'),
            subtitle: TextFormField(
              controller: profileController.cityText,
            ),
          ),
          SizedBox(
            height: 120,
          )
        ],
      ),
    );
  }
}
