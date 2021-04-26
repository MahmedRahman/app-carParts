import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/component/custemImgePicker/CustemImagePicker.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppUtils.dart';
import 'package:carpart/app/modules/authiocation/controllers/authiocation_controller.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupDeliveryView extends GetView<AuthiocationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: ListView(
            children: [
              AuthiocationHeader(
                title: 'حياك معنا',
              ),
              CustemTextForm(
                textHint: 'رقم الهوية',
                inputcontroller: controller.nationalNumber,
              ),
              CustemImagePicker(
                title: 'صورة من الهوية',
                onclick: (value) {
                  controller.nationalIdBytes = value;
                },
              ),
              CustemImagePicker(
                title: 'استمارة السيارة',
                onclick: (value) {
                  controller.carPaperBytes = value;
                },
              ),
              CustemImagePicker(
                title: 'رخصة القيادة',
                onclick: (value) {
                  controller.drivingLicenseBytes = value;
                },
              ),
              CustemImagePicker(
                title: 'صورة السيارة من الامام',
                onclick: (value) {
                  controller.carFrontBytes = value;
                },
              ),
              CustemImagePicker(
                title: 'صورة السيارة من الخلف',
                onclick: (value) {
                  controller.carPaperBytes = value;
                },
              ),
              CustemButton(
                title: 'تسجيل',
                buttonController:controller.btnController,
                onPressed: () {
                  controller.upgrateDelivery();
   
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
