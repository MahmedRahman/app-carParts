import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class FrogatepasswordView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body:  Column(
        children: [
          AuthiocationHeader(
            title: 'نسيت كلمة السر',
          ),
          Text('برجاء كتابة البريد الالكترونى'),
         
          CustemTextForm(textHint: 'البريد الالكتروني'),
         
          CustemButton(
            title: 'إرسال',
            onPressed: () {
              Get.toNamed(Routes.HOME);
            },
          )
        ],
      ),
    );
  }
}
  