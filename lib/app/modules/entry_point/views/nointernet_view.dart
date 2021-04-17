import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NointernetView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Lottie.asset('images/no-connection-internet.json'),
          Center(
            child: Text(
              'خطاء فى الانترانت',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
