import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

const KuserToken = 'usertoken';
const KuserRoal = 'userRoal';
const KuserEmail = 'email';
const KuserUserName = 'username';

class UserAuth extends GetxService {
  String _tokan;
  // userRole _role = userRole.anonymous;
  GetStorage storage = GetStorage();

  void setUserToken(String value) {
    storage.write(KuserToken, value);
  }

  void setUserName(String value) {
    storage.write(KuserUserName, value);
  }

  void setUserEmail(String value) {
    storage.write(KuserEmail, value);
  }

  void setRole(userRole role) {
    storage.write(KuserRoal, role.toString());
  }

  String getUserToken() {
    return storage.read(KuserToken);
  }

  String getUserName() {
    return storage.read(KuserUserName);
  }

  String getUserEmail() {
    return storage.read(KuserEmail);
  }

  userRole getRole() {
    String Role = storage.read(KuserRoal);

    switch (Role) {
      case 'userRole.Buyer':
        return userRole.Buyer;
        break;
      case 'userRole.Delivery':
        return userRole.Delivery;
        break;
      case 'userRole.dealer':
        return userRole.dealer;
        break;
      default:
        return userRole.anonymous;
    }
  }

  void signout() {
    Get.find<UserAuth>().setRole(userRole.anonymous);
  Get.toNamed(Routes.SplashView);
   Future.delayed(Duration(seconds: 1), () {
      Get.toNamed(Routes.HOME);
    });
  }
}
