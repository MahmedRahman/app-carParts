import 'package:carpart/app/api/response_model.dart';
import 'package:carpart/app/api/webServices.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/modules/profile/model/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  TextEditingController nameText = new TextEditingController();
  TextEditingController emailText = new TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    nameText.text = KName;
    emailText.text = KEmail;

    super.onInit();
  }

  //TODO: Implement ProfileController
  //
  //

  final count = 0.obs;

  setProfile() async {
    ProfileModel profileModel = new ProfileModel(
        name: nameText.text, email: emailText.text, logoBytes: '');

    ResponsModel responsModel = await WebServices().setProfile(profileModel);

    if (responsModel.success) {
      print(responsModel.data.bodyString);
      KName = nameText.text;
      KEmail = emailText.text;
      Get.back();
    }
  }
}
