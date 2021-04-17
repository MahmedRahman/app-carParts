import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/data/model/order_model.dart';
import 'package:carpart/app/data/webServices.dart';
import 'package:carpart/app/modules/home/controllers/home_controller.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class OrderAddController extends GetxController {
  var carMarkid = 0;
  var carModelId = 0;
  TextEditingController versionYear = new TextEditingController();
  TextEditingController vanNumber = new TextEditingController();
  TextEditingController description = new TextEditingController();
  String carImageBytes;

  final RoundedLoadingButtonController btnSubmit =
      new RoundedLoadingButtonController();

  createorder() async {
    if (KRole == userRole.anonymous) {
      Get.toNamed(Routes.SigninView);
    }

    if (KRole == userRole.Client) {
      if (carMarkid == 0 || carModelId == 0) {
        showSnackBar(
          message: 'برجاء تحديد نوع و موديل السيارة',
          snackbarStatus: () {
            btnSubmit.stop();
          },
        );
      } else {
        Response response = await WebServices().createorder(
          markid: carMarkid,
          modelId: carModelId,
          versionId: versionYear.text,
          vanNumber: vanNumber.text,
          description: description.text,
          imageBytes: carImageBytes,
        );

        if (response.body['IsSuccess']) {
          showSnackBar(
            message: 'تم حفظ البيانات',
            snackbarStatus: () {
              btnSubmit.stop();
              clearFormData();
              Get.find<HomeController>().selectindex.value = 1;
            },
          );
        } else {
          showSnackBar(
            message: 'خطاء فى البيانات المرسالة',
            snackbarStatus: () {
              btnSubmit.stop();
            },
          );
        }
      }
    }
  }

  restBtn() {
    btnSubmit.stop();
  }

  clearFormData() {
    versionYear.clear();
    vanNumber.clear();
    description.clear();
    carMarkid = 0;
    carModelId = 0;
    carImageBytes = '';
  }
}
