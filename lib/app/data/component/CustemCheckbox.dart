import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustemCheckbox extends StatelessWidget {
  CustemCheckbox({@required this.onChanged});
  var checked = false.obs;
  void Function(bool) onChanged;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          Checkbox(
            value: checked.value,
            onChanged: (bool newValue) {
              checked.value = newValue;
              onChanged(newValue);
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
