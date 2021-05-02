import 'package:carpart/app/modules/authiocation/controllers/authiocation_controller.dart';
import 'package:carpart/app/modules/authiocation/views/forgatepassword_rest_view.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FrogatepasswordOtpView extends GetView<AuthiocationController> {
  @override
  Widget build(BuildContext context) {
    //AuthiocationController controller = Get.put(AuthiocationController());
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            AuthiocationHeader(
              title: 'برجاء كتابة الكود المرسل على رقم الجوال',
            ),
            CustemTextForm(
              textHint: 'الكود المرسل',
              textInputType: TextInputType.phone,
            ),
            CustemButton(
              title: 'تاكيد',
              onPressed: () {

Get.to(FrogatepasswordRestView());

              //  if()
                //controller.setForgotPassword();
              },
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff445969), // background
                  ),
                  onPressed: () {
                    controller.setForgotPassword();
                    //  Get.to(ComplateView());
                  },
                  child: Text('ارسل الكود مرة اخرى'),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
