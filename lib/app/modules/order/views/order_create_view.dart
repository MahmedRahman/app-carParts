import 'dart:async';
import 'dart:io';

import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemDropdown.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:carpart/app/data/component/custemImgePicker/CustemImagePicker.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/data/helper/AppUtils.dart';
import 'package:carpart/app/data/component/custemImgePicker/ImagePicker.dart';
import 'package:carpart/app/data/helper/AppValidation.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/modules/order/controllers/order_controller.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class OrderCreateView extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
            (KRole == userRole.anonymous || KRole == userRole.Client)
                ? Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                        CustomDropdownButton(
                          dropdownDate: carMark,
                          onChanged: (value) {
                            controller.markid.value = int.parse(value);
                            //carModel = carModel.where((i) => i.).toList();
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomDropdownButton(
                          dropdownDate: carModel,
                          onChanged: (value) {
                            controller.modelId.value = int.parse(value);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustemTextForm(
                          textHint: 'سنة الصنع',
                          inputcontroller: controller.versionYear,
                          textInputType: TextInputType.number,
                          onValidator: (value) {
                            return AppValidation.checkEmpty(value);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustemTextForm(
                          textHint: 'رقم الهيكل',
                          inputcontroller: controller.vanNumber,
                          textInputType: TextInputType.number,
                          onValidator: (value) {
                            return AppValidation.checkEmpty(value);
                          },
                        ),
                        CustemTextForm(
                          textmaxLines: 5,
                          textHint: 'اوصف طلبك',
                          inputcontroller: controller.description,
                          onValidator: (value) {
                            return AppValidation.checkEmpty(value);
                          },
                        ),
                        CustemImagePicker(
                          onclick: (value) {
                            controller.imageBytes = value;
                          },
                        ),
                        CustemButton(
                          title: 'ارسال',
                          buttonController: controller.btnController,
                          onPressed: () {
                            if (KRole == userRole.anonymous) {
                              showSnackBar(
                                  title: AppName,
                                  message: 'برجاء تسجيل دخول',
                                  snackbarStatus: () {
                                    controller.restBtn();
                                    Get.toNamed(Routes.SigninView);
                                  });
                            } else {
                              if (_formKey.currentState.validate()) {
                                controller.createorder();
                              } else {
                                controller.restBtn();
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 250,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Text(
                          'برجاء التسجيل كمشترى للتمكن من ارسال طلب جديد',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
