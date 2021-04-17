import 'package:carpart/app/data/model/order_model.dart';
import 'package:carpart/app/data/webServices.dart';
import 'package:get/get.dart';

class OrderListController extends GetxController {
  //TODO: Implement OrderListController
  //
  //

  final orderModelList = Future.value().obs;

  Future getOrder() async {
    Response response = await WebServices().getOrder();
    print(response.bodyString);
    if (response == null) {
      return Future.error('error');
    } else {
      final orderModel = orderModelFromJson(response.bodyString);
      orderModelList.value = Future.value(orderModel);
      return orderModel;
    }
  }
}
