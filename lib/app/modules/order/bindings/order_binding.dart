import 'package:carpart/app/data/repostory.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:carpart/app/modules/order/controllers/order_controller.dart';



class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(
      () => OrderController(),
    );
  }
}
