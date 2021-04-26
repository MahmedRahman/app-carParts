import 'package:carpart/app/api/response_model.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/data/model/order_model.dart';
import 'package:carpart/app/api/webServices.dart';
import 'package:carpart/app/modules/home/controllers/home_controller.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class OrderAddController extends GetxController {
  var carMarkid = 0;
  var carModelId = 0;
  var versionYear = ''.obs;
  //TextEditingController versionYear = new TextEditingController();
  TextEditingController vanNumber = new TextEditingController();
  TextEditingController description = new TextEditingController();
  String carImageBytes;

  final RoundedLoadingButtonController btnSubmit =
      new RoundedLoadingButtonController();

  createorder() async {
    if (KRole == userRole.anonymous) {
      clearFormData();
      Get.toNamed(Routes.SigninView);
    }

    if (KRole == userRole.Client) {
      if (carMarkid == 0 || carModelId == 0 || versionYear.value == '') {
        showSnackBar(
          message: 'برجاء تحديد ماركة و نوع وسنة المركبة',
          snackbarStatus: () {
            btnSubmit.stop();
          },
        );
      } else {
        ResponsModel responsModel = await WebServices().createorder(
          markid: carMarkid,
          modelId: carModelId,
          versionId: versionYear.value,
          vanNumber: vanNumber.text,
          description: description.text,
          imageBytes: carImageBytes,
        );

        if (responsModel.success) {
          Response response = responsModel.data;
          if (response.body['IsSuccess']) {
            showSnackBar(
              message: 'تم ارسال الطلب بنجاح',
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
  }

  restBtn() {
    btnSubmit.stop();
  }

  clearFormData() {
    versionYear.value='';
    vanNumber.clear();
    description.clear();
    carMarkid = 0;
    carModelId = 0;
    carImageBytes = '';
  }
}
