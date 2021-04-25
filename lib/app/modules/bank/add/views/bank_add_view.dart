import 'package:carpart/app/data/component/CustemDropdown.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bank_add_controller.dart';

class BankAddView extends GetView<BankAddController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('أضافة حساب بنكى'),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.save), onPressed: () {
                    FocusScope.of(context).unfocus();
          controller.addBank();
        })],
      ),
   
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),

            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'أسم البنك',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CustomDropdownButton(
            dropdownDate: bankName,
            onChanged: (value) {
              controller.bankId.text = value;
            },
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'رقم اى بان',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          CustemTextForm(
            textHint: 'iban ',
            inputcontroller: controller.iBAN,
            textInputType: TextInputType.number,
          )
        ],
      ),
    );
  }
}
