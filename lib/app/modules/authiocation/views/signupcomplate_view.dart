import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppUtils.dart';
import 'package:carpart/app/data/helper/AppValidation.dart';
import 'package:carpart/app/modules/authiocation/controllers/authiocation_controller.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemDropdown.dart';
import 'package:carpart/app/data/component/CustemIconButton.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupcomplateView extends GetView<AuthiocationController> {
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
              CustemIconButton(),
              CustemTextForm(
                textHint: 'البريد الالكتروني',
                inputcontroller: controller.email,
                onValidator: (value) {
                  return AppValidation.checkEmail(value);
                },
              ),
              CustemDropdown(dataList: CityName),
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
