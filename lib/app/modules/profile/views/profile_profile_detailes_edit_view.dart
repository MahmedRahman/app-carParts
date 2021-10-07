import 'package:carpart/app/data/component/CustomImageCached.dart';
import 'package:carpart/app/data/component/MapSample.dart';
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
            showimagepath: KUserImage.value,
            onclick: (value) {
              profileController.imagelogo = value;
            },
          ),
          defaulttext(
            title: 'الاسم الشخصى',
            controller: profileController.nameText,
          ),
          defaulttext(
            title: 'البريد الالكترونى',
            controller: profileController.emailText,
          ),
          defaulttext(
            title: 'المدينة',
            controller: profileController.cityText,
          ),
          defaulttext(
            title: 'العنوان',
            controller: profileController.adressText,
          ),
          SizedBox(
            width: Get.width,
            height: 350,
            child: MapSample(),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  defaulttext({@required title, @required controller}) => ListTile(
        dense: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(),
            ),
            controller: controller,
          ),
        ),
      );
}
