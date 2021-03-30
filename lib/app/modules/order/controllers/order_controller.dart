import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/data/model/order_model.dart';
import 'package:carpart/app/modules/order/bindings/order_binding.dart';
import 'package:carpart/app/modules/order/providers/order_provider_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  //TODO: Implement OrderController
  TextEditingController vanNumber;
  TextEditingController description;

  createorder() async {
    Response response = await OrderProvider().createorder(
        markid: 1,
        modelId: 1,
        versionId: 1,
        vanNumber: vanNumber.text,
        description: description.text);

    if (response.body['IsSuccess']) {
      showSnackBar(
          title: 'title', message: 'تم حفظ البيانات', snackbarStatus: () {});
    } else {
      showSnackBar(
          title: 'title',
          message: 'خطاء فى البيانات المرسالة',
          snackbarStatus: () {});
    }
  }

  getOrder() async {
    Response response = await OrderProvider().getOrder();

    if (response == null) {
      return Future.error('error');
    } else {
      final orderModel = orderModelFromJson(response.bodyString);
      return orderModel;
    }
  }
}
