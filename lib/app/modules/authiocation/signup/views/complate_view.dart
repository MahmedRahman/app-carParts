import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemDropdown.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:carpart/app/data/component/custemImgePicker/CustemImagePicker.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppValidation.dart';
import 'package:carpart/app/modules/authiocation/signup/controllers/authiocation_signup_controller.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ComplateView extends GetView {
  AuthiocationSignupController controller =
      Get.find<AuthiocationSignupController>();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              AuthiocationHeader(
                title: 'حياك معنا',
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'خطوة اخيرة',
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('برجاء تحديد المدينة'),
              ),
              SizedBox(
                height: 10,
              ),
              CustomDropdownButton(
                dropdownDate: cityName,
                onChanged: (value) {
                  controller.cityid.value = int.parse(value);
                },
              ), SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('برجاء اختيار صورة شخصية'),
              ),
              SizedBox(
                height: 10,
              ),
              CustemImagePicker(
                onclick: (value) {
                  controller.logoBytes = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustemTextForm(
                textHint: 'البريد الالكتروني',
                inputcontroller: controller.email,
                onValidator: (value) {
                  return AppValidation.checkEmail(value);
                },
              ),
              CustemButton(
                title: 'إرسال',
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    controller.createUser();
                  } 
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
