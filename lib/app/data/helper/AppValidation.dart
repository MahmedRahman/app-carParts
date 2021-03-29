import 'package:get/get.dart';

class AppValidation {

  static String checkEmail(String value) {
    if (GetUtils.isEmail(value) == false) {
      return 'Not vaild Email'.tr;
    } else {
      return null;
    }
  }

  static String checkEmpty(String value) {
    if (value.isEmpty) {
      return 'Empty String'.tr;
    }
    return null;
  }

static String validatePassword(String value) {
  if (value.isEmpty) {
    return "* Required".tr;
  } else if (value.length < 6) {
    return "Password should be atleast 6 characters".tr;
  } else if (value.length > 15) {
    return "Password should not be greater than 15 characters".tr;
  } else
    return null;
}

  static String checkMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number'.tr;
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number'.tr;
    }
    return null;
  }
}
