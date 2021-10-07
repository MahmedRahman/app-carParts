import 'package:carpart/app/api/response_model.dart';
import 'package:carpart/app/api/webServices.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/modules/profile/model/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  TextEditingController nameText = new TextEditingController();
  TextEditingController emailText = new TextEditingController();

  TextEditingController cityText = new TextEditingController();

  TextEditingController adressText = new TextEditingController();
  var imagelogo;
  @override
  void onInit() {
    nameText.text = KName.value;
    emailText.text = KEmail.value;
    cityText.text = KCity.value;
    adressText.text = KAdress.value;
    super.onInit();
  }

  final count = 0.obs;

  setProfile() async {
    if (GetUtils.isNullOrBlank(nameText.text) ||
        GetUtils.isEmail(emailText.text) == false) {
      showSnackBar(
          message: 'برجاء كتابة بيانات للتغير الاسم و البريد الالكترونى',
          snackbarStatus: () {});
    } else {
      ProfileModel profileModel = new ProfileModel(
        name: nameText.text,
        email: emailText.text,
        logoBytes: imagelogo,
        address: adressText.text,
        lat: Klatitude,
        lng: Klongitude
      );

      ResponsModel responsModel = await WebServices().setProfile(profileModel);

      if (responsModel.success) {
        Response response = responsModel.data;

        GetUtils.isNullOrBlank(response.body['Data']['Logo'].toString())
            ? KUserImage.value = 'https://via.placeholder.com/75'
            : KUserImage.value =
                'https://carpart.atpnet.net/Files/User/Client/' +
                    response.body['Data']['Id'].toString() +
                    '/' +
                    response.body['Data']['Logo'].toString();

        KName.value = nameText.text;
        KEmail.value = emailText.text;

        Get.back();
      }
    }
  }
}
