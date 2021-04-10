import 'package:carpart/app/data/model/payment_model.dart';
import 'package:carpart/app/data/webServices.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class PaymentListController extends GetxController {
  //TODO: Implement PaymentListController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future getPaymentRequest() async {
    Response response = await WebServices().getPaymentRequest();
    final paymentModel = paymentModelFromJson(response.bodyString);
    return paymentModel;
  }
}
