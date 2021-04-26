import 'package:get/get.dart';

import '../controllers/authiocation_signup_controller.dart';

class AuthiocationSignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthiocationSignupController>(
      () => AuthiocationSignupController(),
    );
  }
}
