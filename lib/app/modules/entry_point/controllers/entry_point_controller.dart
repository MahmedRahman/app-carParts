import 'dart:convert';

import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/model/setting_model.dart';
import 'package:carpart/app/data/webServices.dart';

import 'package:carpart/app/routes/app_pages.dart';
import 'package:get/get.dart';

class EntryPointController extends GetxController {
  //TODO: Implement EntryPointController

  @override
  void onInit() async {}

  void Start() async {
    await fillLookUpTable().then((value) {
      Get.offNamed(Routes.HOME);
    });

    super.onInit();
  }

  Future fillLookUpTable() async {
    await getProfile();
    await getcity();
    await getcarMark();
    await getcarModel();
    await getBank();
    await getSetting();
  }

  Future getcity() async {
    Response response = await WebServices().getcity();
    print(response.bodyString);

    List<dynamic> ListCity = jsonDecode(response.bodyString);

    ListCity.forEach((element) {
      cityName.add({
        "id": "" + element['Id'].toString() + "",
        "title": "" + element['Name'].toString() + "",
      });
    });
  }

  Future getcarMark() async {
    Response response = await WebServices().getMark();
    print(response.bodyString);

    List<dynamic> ListData = jsonDecode(response.bodyString);

    ListData.forEach((element) {
      carMark.add({
        "id": "" + element['Id'].toString() + "",
        "title": "" + element['Name'].toString() + "",
      });
    });
  }

  Future getcarModel() async {
    Response response = await WebServices().getModel();
    print(response.bodyString);

    List<dynamic> ListData = jsonDecode(response.bodyString);

    ListData.forEach((element) {
      carModel.add({
        "id": "" + element['Id'].toString() + "",
        "title": "" + element['Name'].toString() + "",
      });
    });
  }

  Future getBank() async {
    Response response = await WebServices().getBank();
    print(response.bodyString);

    List<dynamic> ListData = jsonDecode(response.bodyString);

    ListData.forEach((element) {
      bankName.add({
        "id": "" + element['Id'].toString() + "",
        "title": "" + element['Name'].toString() + "",
      });
    });
  }

  Future getSetting() async {
    Response response = await WebServices().getSetting();
    final settingModel = settingModelFromJson(response.bodyString);

    pageAbout = Future.value(settingModel.about);
    pageCallus = Future.value(settingModel.callUs);
    pageTream = Future.value(settingModel.terms);

    KMPriceMin = settingModel.kmPriceMin;
    KMPriceMax = settingModel.kmPriceMax;
    helpPhoneNumber = settingModel.helpPhoneNumber;
    print(response.bodyString);
  }

  Future getProfile() async {
    Response response = await WebServices().getProfile();

    if (response.statusCode == 401) {
      KRole = userRole.anonymous;
    } else {
      KName = response.body['Name'];
      KEmail = response.body['Email'];
      KCity = response.body['CityName'];

      Klatitude = response.body['Lat'];
      Klongitude = response.body['Lng'];

      KRole = userRole.values[response.body['Role']];
    }
  }
}
