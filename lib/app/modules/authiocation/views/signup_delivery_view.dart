import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppUtils.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupDeliveryView extends GetView {
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
              CustemTextForm(textHint: 'رقم الهوية'),
              CustemTextForm(
                textHint: 'صورة شخصية',
                textIconData: Icons.camera_alt_rounded,
              ),
              CustemTextForm(
                textHint: 'صورة من الهوية',
                textIconData: Icons.camera_alt_rounded,
              ),
              CustemTextForm(
                textHint: 'استمارة السيارة',
                textIconData: Icons.camera_alt_rounded,
              ),
              CustemTextForm(
                textHint: 'رخصة القيادة',
                textIconData: Icons.camera_alt_rounded,
              ),
              CustemTextForm(
                textHint: 'صورة السيارة من الامام',
                textIconData: Icons.camera_alt_rounded,
              ),    CustemTextForm(
                textHint: 'صورة السيارة من الخلف',
                textIconData: Icons.camera_alt_rounded,
              ),
              CustemButton(
                title: 'تسجيل',
                onPressed: () {
                 AppUtils().showSnackBar(
                  AppName,
                  'لقد قمت بالتسجيل انت الان تتمتع بصلاحيات المندوب',
                  snackbarStatus: (value) {
                    Get.find<UserAuth>().setRole(userRole.Delivery);

                    if (value == SnackbarStatus.CLOSED) {
                      Get.toNamed(Routes.HOME);
                    }
                  },
                );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
