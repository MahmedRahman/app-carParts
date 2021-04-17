import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class connectivity extends GetxService {
  final Connectivity _connectivity = Connectivity();
  Widget Nointernet = NointernetView();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    var connectivityResult = await (_connectivity.checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Get.to(Nointernet);
    }

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        Get.to(Nointernet);
      }
    });
    super.onReady();
  }

  Future<ConnectivityResult> getConnectivityState() async {
    var connectivityResult = await (_connectivity.checkConnectivity());
    return connectivityResult;
  }
}

class NointernetView extends GetView {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
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
            TextButton(
                onPressed: () {
                  Get.find<connectivity>().getConnectivityState().then((ConnectivityResult value) {
                    if (value == ConnectivityResult.none) {
                      showSnackBar(message: 'برجاء التاكد من وجود انترانت', snackbarStatus: () {});
                    } else {
                      Get.back();
                    }
                  });
                },
                child: Text('أعادة المحاولة'))
          ],
        ),
      ),
    );
  }
}
