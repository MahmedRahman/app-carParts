import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/routes/app_pages.dart';
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
          InkWell(
            onTap: (){
              Get.toNamed(Routes.TREMSNEW);
            },
            child: Text(
              'اوافق على شروط الاستخدام و سياسة الخصوصية',
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      );
    });
  }
}
