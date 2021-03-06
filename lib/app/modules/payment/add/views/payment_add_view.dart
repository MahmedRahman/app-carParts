import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/payment_add_controller.dart';

class PaymentAddView extends GetView<PaymentAddController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('أضافة بيانات التحويل'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                FocusScope.of(context).unfocus();

                controller.addPaymentRequest();
              })
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'الرجاء كتابة المبلغ المراد تحويلة',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          CustemTextForm(
            textHint: 'أدخل المبلغ المراد تحويلة',
            inputcontroller: controller.price,
            textInputType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
