import 'package:carpart/app/data/helper/AppValidation.dart';
import 'package:carpart/app/modules/authiocation/controllers/authiocation_controller.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemCheckbox.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupView extends GetView<AuthiocationController> {
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
                onValidator: (value) {
                  return AppValidation.validatePassword(value);
                },
              ),
              CustemTextForm(
                  textHint: 'تأكيد كلمة المرور',
                  inputcontroller: controller.confirmPassword,
                  onValidator: (value) {
                    return AppValidation.validatePassword(value);
                  }),
              CustemCheckbox(),
              CustemButton(
                title: 'التالي',
                buttonController: controller.btnController,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Get.toNamed(Routes.SignupcomplateView);
                  } else {
                    controller.btnController.reset();
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
