import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bank_controller.dart';

class BankView extends GetView<BankController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BankView'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getUserBank(),
        builder: (_c, _x) {
          return Text('data');
        },
      ),
    );
  }
}
