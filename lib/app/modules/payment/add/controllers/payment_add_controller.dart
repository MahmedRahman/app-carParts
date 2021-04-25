import 'package:carpart/app/api/response_model.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/api/webServices.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentAddController extends GetxController {
  //TODO: Implement PaymentAddController
  TextEditingController price = new TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    price.text = '50';
    super.onInit();
  }

  addPaymentRequest() async {
    ResponsModel responsModel =
        await WebServices().addPaymentRequest(int.parse(price.text));
    if (responsModel.success) {
      Response response = responsModel.data;
      if (response.body['IsSuccess']) {
        showSnackBar(
            title: AppName,
            message: 'تم حفظ بنجاح',
            snackbarStatus: () {
              Get.offNamed(Routes.PAYMENT_LIST);
            });
      } else {
        showSnackBar(
            title: AppName,
            message: 'خطاء فى حفظ البيانات',
            snackbarStatus: () {});
      }

      return response;
    }
  }
}
