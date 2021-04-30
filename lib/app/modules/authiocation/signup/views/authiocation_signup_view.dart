import 'package:carpart/app/data/component/CustemCheckbox.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:carpart/app/data/helper/AppValidation.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/modules/authiocation/signup/views/otp_view.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/authiocation_signup_controller.dart';

class AuthiocationSignupView extends GetView<AuthiocationSignupController> {
  @override
  Widget build(BuildContext context) {
    bool checkboxValue =false;
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
              CustemTextForm(
                textHint: 'الاسم',
                inputcontroller: controller.name,
                onValidator: (value) {
                  return AppValidation.checkEmpty(value);
                },
              ),
              CustemTextForm(
                textHint: 'رقم الجوال',
                inputcontroller: controller.phoneNumber,
                textInputType: TextInputType.phone,
                onValidator: (value) {
                  return AppValidation.checkMobile(value);
                },
              ),
              CustemTextForm(
                textHint: 'كلمة المرور',
                inputcontroller: controller.password,
                textInputType: TextInputType.visiblePassword,
                onValidator: (value) {
                  return AppValidation.validatePassword(value);
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustemCheckbox(
                onChanged: (value) {
                  checkboxValue = value;
                  print(value.toString());
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (checkboxValue) {
                    if (_formKey.currentState.validate()) {

controller.isPhonelExist();

                      
                    }
                  } else {
                    showSnackBar(
                        message: 'برجاء الموافقة على اتفاقية الاستخدام',
                        snackbarStatus: () {});
                  }
                },
                child: Text('التالى'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
