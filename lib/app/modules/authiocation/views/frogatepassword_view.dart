import 'package:carpart/app/modules/authiocation/controllers/authiocation_controller.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FrogatepasswordView extends GetView<AuthiocationController> {
  @override
  Widget build(BuildContext context) {
    AuthiocationController controller = Get.put(AuthiocationController());
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AuthiocationHeader(
              title: 'نسيت كلمة السر',
            ),
           
            CustemTextForm(
              textHint: 'رقم الجوال',
              inputcontroller: controller.phoneNumber,
              textInputType: TextInputType.phone,
            ),
            CustemButton(
              title: 'إرسال',
              onPressed: () {
                controller.setForgotPassword();
                //Get.toNamed(Routes.HOME);
                //
              },
            )
          ],
        ),
      ),
    );
  }
}
