import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
    var selectindex = 0.obs;
  final count = 0.obs;

  @override
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}

  void increment() => count.value++;
}
