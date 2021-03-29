import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemDropdown.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/data/helper/AppUtils.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class OrderCreateView extends GetView {
  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'images/bg_home.png',
            ),
          ),
        ),
        child: ListView(
          children: [
            SizedBox(
              height: Get.height * .3,
              child: PageView(
                scrollDirection: Axis.horizontal,
                children: [
                  Center(
                    child: Image.asset('images/Banner1.jpg'),
                  ),
                  Center(
                    child: Image.asset('images/Banner1.jpg'),
                  ),
                  Center(
                    child: Image.asset('images/Banner1.jpg'),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'آمر',
                  style: headline1.copyWith(
                    color: KScandaryColor,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('؟',
                    style: headline1.copyWith(
                      color: KAccentColor,
                    )),
              ],
            ),
            CustemDropdown(
              dataList: CarBrand,
            ),
            CustemDropdown(
              dataList: CarType,
            ),
            CustemDropdown(
              dataList: CarModel,
            ),
            CustemTextForm(
              textHint: 'رقم الهيكل',
            ),
            CustemTextForm(
              textmaxLines: 5,
              textHint: 'اوصف طلبك',
            ),
            CustemTextForm(
              textHint: 'ارفق صورة',
              textIconData: Icons.camera_alt_rounded,
            ),
            CustemButton(
              title: 'ارسال',
              onPressed: () {
                if (Get.find<UserAuth>().getRole() == userRole.anonymous) {
                  AppUtils().showSnackBar(AppName, 'برجاء تسجيل دخول',
                      snackbarStatus: (value) {
                    if (value == SnackbarStatus.CLOSED) {
                      Get.toNamed(Routes.SigninView);
                    }
                  });
                } else {
                  AppUtils().showSnackBar(AppName, 'تم أضافة الطلب',
                      snackbarStatus: (value) {
                    if (value == SnackbarStatus.CLOSED) {
                      //Get.toNamed(Routes.SigninView);
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
