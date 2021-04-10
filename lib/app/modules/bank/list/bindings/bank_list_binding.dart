import 'package:get/get.dart';

import '../controllers/bank_list_controller.dart';

class BankListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankListController>(
      () => BankListController(),
    );
  }
}
