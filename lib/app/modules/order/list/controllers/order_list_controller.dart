import 'package:carpart/app/api/response_model.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/model/order_model.dart';
import 'package:carpart/app/api/webServices.dart';
import 'package:get/get.dart';

class OrderListController extends GetxController {
  //TODO: Implement OrderListController
  //
  //

  final orderModelList = Future.value().obs;

  Future getOrder() async {
    ResponsModel responsModel = await WebServices().getOrder();

    if (responsModel.success) {
      Response response = responsModel.data;
      final orderModel = orderModelFromJson(response.bodyString);
      orderModelList.value = Future.value(orderModel);
      return orderModel;
    }
  }

  deleteOrder(String Orderid) async {
    ResponsModel responsModel = await WebServices().deleteOrder(Orderid);

    if (responsModel.success) {
      Response response = responsModel.data;
      if (response.body['IsSuccess']) {
      
        Get.snackbar(AppName, 'تم الحذف');
        getOrder();
      } else {
         Get.snackbar(AppName, 'خطاء');
      }
    }
  }
}
