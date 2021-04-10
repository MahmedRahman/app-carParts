import 'package:get/get.dart';

import '../controllers/bank_add_controller.dart';

class BankAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankAddController>(
      () => BankAddController(),
    );
  }
}
