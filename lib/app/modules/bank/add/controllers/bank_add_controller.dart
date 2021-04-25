import 'package:carpart/app/api/response_model.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/api/webServices.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BankAddController extends GetxController {
  //TODO: Implement BankAddController

  TextEditingController bankId = new TextEditingController();
  TextEditingController iBAN = new TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    bankId.text = '1';
    super.onInit();
  }

  addBank() async {
    ResponsModel responsModel =
        await WebServices().addUserBank(int.parse(bankId.text), iBAN.text);

    if (responsModel.success) {
      Response response = responsModel.data;
      if (response.body['IsSuccess']) {
        showSnackBar(
            title: AppName,
            message: 'تم الحفظ بنجاح',
            snackbarStatus: () {
              Get.offNamed(Routes.BANK_LIST);
            });
      } else {
        showSnackBar(
            title: AppName,
            message: 'خطأ فى حفظ البيانات',
            snackbarStatus: () {});
      }
      return response;
    }
  }
}
