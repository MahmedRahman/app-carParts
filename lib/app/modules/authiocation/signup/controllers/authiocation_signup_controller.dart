import 'dart:io';
import 'package:carpart/app/api/response_model.dart';
import 'package:carpart/app/api/webServices.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AuthiocationSignupController extends GetxController {
  TextEditingController name = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  TextEditingController businessName = new TextEditingController();

  final RoundedLoadingButtonController btnController =
      new RoundedLoadingButtonController();

  var cityid = 0.obs;

  String logoBytes;

  String smsCode;

  void createUser() async {
    String deviceId = await _getId();

    if (cityid.value == 0) {
      bntrest();
      showSnackBar(message: 'برجاء اختيار المدينة', snackbarStatus: () {});
    } else {
      ResponsModel responsModel = await WebServices().createUser(
        name: name.text,
        email: email.text,
        password: password.text,
        phoneNumber: phoneNumber.text,
        cityid: cityid.value,
        deviceId: deviceId,
        logoBytes: logoBytes,
      );

      if (responsModel.success) {
        Response response = responsModel.data;

        if (response.body['IsSuccess']) {
          showSnackBar(
              title: AppName,
              message: 'تم تسجيل الحساب بنجاح',
              snackbarStatus: () {
                bntrest();
                Get.toNamed(Routes.SigninView,arguments: [phoneNumber.text,password.text]);
              });
        } else {
          showSnackBar(
              title: AppName,
              message: response.body['Message'],
              snackbarStatus: () {
                bntrest();
              });
        }
      } else{
        bntrest();
      }
    }
  }

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId;
    }
  }

  void sendSms() async {
    ResponsModel responsModel = await WebServices().sendSms(phoneNumber.text);
    if (responsModel.success) {
      Response response = responsModel.data;
      if (response.body['IsSuccess']) {
        smsCode = response.body['Data'];
        print(response.body['Data']);
      }
    }
  }

  void bntrest() {
    btnController.stop();
  }
}
