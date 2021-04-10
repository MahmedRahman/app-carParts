import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/data/webServices.dart';
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
    Response response =
        await WebServices().addPaymentRequest(int.parse(price.text));

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
          snackbarStatus: () {
           
          });
    }

    return response;
  }
}
