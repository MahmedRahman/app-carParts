import 'package:carpart/app/data/component/CustemDropdown.dart';
import 'package:carpart/app/data/component/custemImgePicker/CustemImagePicker.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppUtils.dart';
import 'package:carpart/app/data/helper/AppValidation.dart';
import 'package:carpart/app/modules/authiocation/controllers/authiocation_controller.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemIconButton.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupcomplateView extends GetView<AuthiocationController> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
              CustemImagePicker(
                onclick: (value) {
                  controller.logoBytes = value;
                },
              ),
              CustemTextForm(
                textHint: 'البريد الالكتروني',
                inputcontroller: controller.email,
                onValidator: (value) {
                  return AppValidation.checkEmail(value);
                },
              ),
              CustomDropdownButton(
                dropdownDate: cityName,
                onChanged: (value) {
                  controller.cityid.value = int.parse(value);
                },
              ),
              CustemButton(
                title: 'إرسال',
                buttonController: controller.btnController,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    controller.createUser();
                  } else {
                    controller.bntrest(); 
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
