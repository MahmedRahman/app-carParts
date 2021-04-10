import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/stoperror_controller.dart';

class StoperrorView extends GetView<StoperrorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'خطاء فى البرنامج',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Center(
              child: Text(
                Get.arguments[0],
                style: TextStyle(fontSize: 20),
              ),
            ),
            Center(
              child: Text(
                Get.arguments[1],
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
                onPressed: () {
           
                  print(Get.find<UserAuth>().getUserToken().toString());
                  Get.toNamed(Routes.ENTRY_POINT);
                },
                child: Text('حاول مرة اخرى'))
          ],
        ),
      ),
    );
  }
}
