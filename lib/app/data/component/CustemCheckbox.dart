
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustemCheckbox extends StatelessWidget {
  var checked = false.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          Checkbox(
            value: checked.value,
            onChanged: (bool newValue) {
              print(newValue.toString());
              checked.value = newValue;
            },
            activeColor: KAccentColor,
          ),
          Text(
            'اوافق على شروط الاستخدام و سياسة الخصوصية',
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      );
    });
  }
}
