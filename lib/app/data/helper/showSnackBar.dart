

import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar({
     String title = AppName,
    @required String message,
    @required snackbarStatus(),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: KScandaryColor,
      colorText: Colors.white,
      overlayBlur: 4,
      borderWidth: 2,
      margin: EdgeInsets.all(10),
      borderColor: KScandaryColor,
      snackbarStatus: (value) {


        if (value == SnackbarStatus.CLOSED) {
          snackbarStatus();
        }

    
        
        //onstatusBarClosed(value);
      },
    );
  }