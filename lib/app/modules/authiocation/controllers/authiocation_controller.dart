import 'dart:io';

import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppUtils.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/data/model/client_model.dart';
import 'package:carpart/app/data/model/userModel.dart';
import 'package:carpart/app/data/webServices.dart';
import 'package:carpart/app/modules/entry_point/controllers/entry_point_controller.dart';

import 'package:carpart/app/routes/app_pages.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AuthiocationController extends GetxController {
  TextEditingController name = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  TextEditingController businessName = new TextEditingController();
  final RoundedLoadingButtonController btnController =
      new RoundedLoadingButtonController();
  String registrationImageBytes;

  String logoBytes;
  var cityid = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    phoneNumber.text = "01223560607";
    password.text = "123456";
  }

  void createUser() async {
    String deviceId = await _getId();

    Response response = await WebServices().createUser(
        name: name.text,
        email: email.text,
        password: password.text,
        phoneNumber: phoneNumber.text,
        cityid: cityid.value,
        deviceId: deviceId,
        logoBytes: logoBytes);

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
    // String deviceId = await _getId();
    await WebServices()
        .siginWithPhoneNumber(
      phone: phoneNumber.text,
      password: password.text,
    )
        .then((value) async {
      final userModel = userModelFromJson(value);
      Get.find<UserAuth>().setUserToken(userModel.accessToken);
      await EntryPointController().getProfile();
      setDeviceId();
      showSnackBar(
          title: AppName,
          message: "تم تسجيل الدخول بنجاح",
          snackbarStatus: () {
            Get.toNamed(Routes.HOME);
            btnController.reset();
          });
    }, onError: (err) {
      //print(err);
      showSnackBar(
          title: AppName,
          message: err.toString(),
          snackbarStatus: () {
            btnController.reset();
          });
    });
  }


  void setDeviceId() async{
    
    await WebServices().setDeviceId(KFirebaseMessagingToken);

  }

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  void bntrest() {
    btnController.reset();
  }

  void upgrateMerchant() async {
    Response response = await WebServices().upgrateMerchant(
      businessName: businessName.text,
      registrationImageBytes: registrationImageBytes,
    );

    if (response.statusCode == 200) {
      if (response.body['IsSuccess']) {
        showSnackBar(
            title: AppName,
            message: 'تم تقدم طلب ترقية',
            snackbarStatus: () {
              Get.offNamed(Routes.HOME);
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
          message: 'خطاء فى عملية الترقية',
          snackbarStatus: () {});
    }
  }

  TextEditingController nationalNumber = new TextEditingController();
  String nationalIdBytes;
  String carBackBytes;
  String carFrontBytes;
  String carPaperBytes;
  String drivingLicenseBytes;

  void upgrateDelivery() async {
    Response response = await WebServices().upgrateDelivery(
      nationalNumber: nationalNumber.text,
      nationalIdBytes: nationalIdBytes,
      carBackBytes: carBackBytes,
      carFrontBytes: carFrontBytes,
      carPaperBytes: carPaperBytes,
      drivingLicenseBytes: drivingLicenseBytes,
    );

    if (response.body['IsSuccess']) {
      Get.toNamed(Routes.HOME);
    } else {
//sh
    }
  }
}
