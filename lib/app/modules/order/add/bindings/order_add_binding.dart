import 'package:get/get.dart';

import '../controllers/order_add_controller.dart';

class OrderAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderAddController>(
      () => OrderAddController(),
    );
  }
}
