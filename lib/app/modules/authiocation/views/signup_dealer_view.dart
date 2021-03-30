import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppUtils.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupDealerView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            AuthiocationHeader(
              title: 'حياك معنا',
            ),
            CustemTextForm(textHint: 'اسم النشاط التجاري'),
            CustemTextForm(
              textHint: 'صورة من السجل التجاري',
              textIconData: Icons.camera_alt_rounded,
            ),
            CustemButton(
              title: 'تسجيل',
              onPressed: () {
                AppUtils().showSnackBar(
                  AppName,
                  'لقد قمت بالتسجيل انت الان تتمتع بصلاحيات التاجر',
                  snackbarStatus: (value) {
                    Get.find<UserAuth>().setRole(userRole.dealer);

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
    );
  }
}
