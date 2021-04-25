import 'package:carpart/app/api/response_model.dart';
import 'package:carpart/app/data/model/payment_model.dart';
import 'package:carpart/app/api/webServices.dart';
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
    ResponsModel responsModel = await WebServices().getPaymentRequest();

    if (responsModel.success) {
      Response response = responsModel.data;
      final paymentModel = paymentModelFromJson(response.bodyString);
      return paymentModel;
    }
  }
}
