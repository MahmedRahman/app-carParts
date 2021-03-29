import 'package:get/get.dart';

import 'package:carpart/app/modules/page/controllers/page_controller.dart';

class PageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PageController>(
      () => PageController(),
    );
  }
}
