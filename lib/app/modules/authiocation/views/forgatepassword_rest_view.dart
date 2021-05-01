import 'package:carpart/app/modules/authiocation/controllers/authiocation_controller.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FrogatepasswordRestView extends GetView<AuthiocationController> {
  @override
  Widget build(BuildContext context) {
    //AuthiocationController controller = Get.put(AuthiocationController());
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            AuthiocationHeader(
              title: 'برجاء كتابة كلمة السر',
            ),
            CustemTextForm(
              textHint: 'كلمة السر الجديدة',
              //textInputType: TextInputType.phone,
            ),
            CustemButton(
              title: 'ارسال',
              onPressed: () {
              //  if()
                //controller.setForgotPassword();
              },
            ),
            SizedBox(
              height: 10,
            ),
           
         
          ],
        ),
      ),
    );
  }
}
