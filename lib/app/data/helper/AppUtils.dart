import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUtils {
  void showDialog(String title, String content, Function onPressed) {
    Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(
        color: KAccentColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      radius: 10,
      middleText: 'Save Done'.tr,
      content: Container(
        child: Column(
          children: [
            Text(
              content,
              style: TextStyle(
                color: KScandaryColor,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      confirm: RaisedButton(
        color: KPrimaryColor,
        child: Text('Done'.tr),
        elevation: 2,
        onPressed: onPressed,
      ),
      backgroundColor: KPrimaryColor,
      buttonColor: KPrimaryColor,
      barrierDismissible: false,
    );
  }

  void showSnackBar(String title, String message, {Function snackbarStatus}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: KScandaryColor,
      colorText: Colors.white,
      overlayBlur: 4,
      borderWidth: 2,
      margin: EdgeInsets.all(10),
      borderColor: KAccentColor,
      snackbarStatus: snackbarStatus,
    );
  }
}
