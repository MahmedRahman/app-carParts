import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/modules/home/controllers/home_controller.dart';
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

  String getUserToken() {
    return storage.read(KuserToken);
  }

  void signout() {

    KRole = userRole.anonymous;

    Get.toNamed(Routes.SplashView);

    Future.delayed(Duration(seconds: 1), () {
      Get.find<HomeController>().selectindex.value = 0;
      Get.toNamed(Routes.HOME);
    });
  }
}
