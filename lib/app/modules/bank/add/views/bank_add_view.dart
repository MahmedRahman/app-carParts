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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          controller.addBank();
        },
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          CustomDropdownButton(
            dropdownDate: bankName,
            onChanged: (value){
              controller.bankId.text =value;
            },
          ),
          SizedBox(
            height: 10,
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
