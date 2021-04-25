import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/component/MapSample.dart';
import 'package:carpart/app/data/component/custemImgePicker/CustemImagePicker.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppUtils.dart';
import 'package:carpart/app/modules/authiocation/controllers/authiocation_controller.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SignupDealerView extends GetView<AuthiocationController> {
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
              CustemTextForm(
                textHint: 'اسم النشاط التجاري',
                inputcontroller: controller.businessName,
              ),
              CustemImagePicker(
                onclick: (value) {
                  controller.registrationImageBytes = value;
                },
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: Get.width,
                height: 350,
                child: MapSample(),
              ),
              CustemButton(
                title: 'تسجيل',
                buttonController: controller.btnController,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    controller.upgrateMerchant();
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
