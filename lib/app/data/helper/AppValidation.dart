import 'package:get/get.dart';

class AppValidation {

  static String checkEmail(String value) {
    if (GetUtils.isEmail(value) == false) {
      return 'الرجاء ادخال البريد الالكترونى';
    } else {
      return null;
    }
  }

  static String checkEmpty(String value) {
    if (value.isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    return null;
  }

static String validatePassword(String value) {
  if (value.isEmpty) {
    return "* مطلوب".tr;
  } else if (value.length < 6) {
    return "يجب أن تتكون كلمة المرور من 6 أحرف على الأقل";
  } else if (value.length > 15) {
    return "يجب ألا تزيد كلمة المرور عن 15 حرفًا";
  } else
    return null;
}

  static String checkMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'الرجاء إدخال رقم الجوال';
    } else if (!regExp.hasMatch(value)) {
      return 'الرجاء إدخال رقم جوال صحيح';
    }
    return null;
  }
}
