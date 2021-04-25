import 'package:carpart/app/api/response_model.dart';
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
      return orderModel;}
    
  }
}
