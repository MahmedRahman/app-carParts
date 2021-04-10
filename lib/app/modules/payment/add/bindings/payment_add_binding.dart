import 'package:get/get.dart';

import '../controllers/payment_add_controller.dart';

class PaymentAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentAddController>(
      () => PaymentAddController(),
    );
  }
}
