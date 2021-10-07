import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';

import 'package:carpart/app/data/component/custemImgePicker/CustemImagePicker.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/modules/authiocation/signup/controllers/authiocation_signup_controller.dart';
import 'package:carpart/app/modules/authiocation/signup/views/complate_view.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import 'package:get/get.dart';

class OtpView extends GetView {
  AuthiocationSignupController controller =
      Get.find<AuthiocationSignupController>();

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  TextEditingController textEditing = new TextEditingController();

  CountdownTimerController controllerTimer;

  OtpView() {
    controllerTimer = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  var flg = true.obs;

  void onEnd() {
    flg.value = false;
    controllerTimer.disposeTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          AuthiocationHeader(
            title: 'حياك معنا',
          ),
          Center(
            child: Obx(() {
              return flg.value
                  ? CountdownTimer(
                      controller: controllerTimer,
                      endTime: endTime,
                      widgetBuilder: (_, CurrentRemainingTime time) {
                        if (time == null) {
                          return Text(
                              'تم إرسال كود التحقق المكون من 4 أرقام فقط إلى رقم الهاتف');
                        }
                        return Text(
                          '${time.sec}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    )
                  : Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'تم إرسال كود التحقق المكون من 4 أرقام فقط إلى رقم الهاتف',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    );
            }),
          ),
          SizedBox(
            height: 40,
          ),
          CustemTextForm(
            inputcontroller: textEditing,
            textInputType: TextInputType.number,
            textHint: 'كود الارسال',
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                if (textEditing.text == controller.smsCode) {
                  Get.to(ComplateView());
                } else {
                  showSnackBar(
                    message: 'برجاء كتابة كود تفعيل صحيح',
                    snackbarStatus: () {},
                  );
                }
                // controller.sendSms();
              },
              child: Text('تاكيد'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(() {
            return Opacity(
              opacity: flg.value ? 0 : 1,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff445969), // background
                  ),
                  onPressed: () {
                    controller.sendSms();
                    flg.value = true;
                    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
                    controllerTimer = CountdownTimerController(
                        endTime: endTime, onEnd: onEnd);
                    controllerTimer.start();

                    //  Get.to(ComplateView());
                  },
                  child: Text('ارسل الكود مرة اخرى'),
                ),
              ),
            );
          }),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
