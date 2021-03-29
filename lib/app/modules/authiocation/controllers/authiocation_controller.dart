import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppUtils.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/data/model/client_model.dart';
import 'package:carpart/app/data/model/userModel.dart';
import 'package:carpart/app/modules/authiocation/provider/authiocation_provider.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthiocationController extends GetxController {
  TextEditingController name = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    phoneNumber.text = "0200200200";
    password.text = "200200200";
  }

  void createUser() async {
    Response response = await AuthiocationProvider().createUser(
      name: name.text,
      email: email.text,
      password: password.text,
      phoneNumber: phoneNumber.text,
    );

    if (response.statusCode == 200) {
      if (response.body['IsSuccess']) {
        showSnackBar(
            title: AppName,
            message: 'تم تسجيل الحساب بنجاح',
            snackbarStatus: () {
              Get.toNamed(Routes.SigninView);
            });
      } else {
        showSnackBar(
            title: AppName,
            message: response.body['Message'],
            snackbarStatus: () {});
      }
    } else {
      showSnackBar(
          title: AppName,
          message: 'خطاء فى عملية التسجيل',
          snackbarStatus: () {});
    }
  }

  void siginWithPhoneNumber() async {
    String jsonString = await AuthiocationProvider().siginWithPhoneNumber(
      phone: phoneNumber.text,
      password: password.text,
    );

    final userModel = userModelFromJson(jsonString);

    Get.find<UserAuth>().setUserToken(userModel.accessToken);

    Get.find<UserAuth>().setUserName(userModel.userName);
    Get.find<UserAuth>().setUserEmail(email.text);


    if (userModel.role == 'Client') {
      Get.find<UserAuth>().setRole(userRole.Buyer);
      Get.toNamed(Routes.HOME);
    } else {
      Get.find<UserAuth>().setRole(userRole.anonymous);
    }
  }
}
