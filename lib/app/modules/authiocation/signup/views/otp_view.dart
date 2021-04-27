import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';

import 'package:carpart/app/data/component/custemImgePicker/CustemImagePicker.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/modules/authiocation/signup/controllers/authiocation_signup_controller.dart';
import 'package:carpart/app/modules/authiocation/signup/views/complate_view.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class OtpView extends GetView {
  AuthiocationSignupController controller =
      Get.find<AuthiocationSignupController>();

  TextEditingController textEditing = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          AuthiocationHeader(
            title: 'حياك معنا',
          ),
          CustemTextForm(
            inputcontroller: textEditing,
            textInputType: TextInputType.number,
            textHint: 'برجاء كتابة كود التفعيل',
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                if (textEditing.text == controller.smsCode) {
                  Get.to(ComplateView());
                } else {
                  showSnackBar(
                      message: 'برجاء كتابة كود تفعيل صحيح',
                      snackbarStatus: () {});
                }
                // controller.sendSms();
              },
              child: Text('تاكيد'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff445969), // background
              ),
              onPressed: () {
                controller.sendSms();
                //  Get.to(ComplateView());
              },
              child: Text('ارسل الكود مرة اخرى'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
