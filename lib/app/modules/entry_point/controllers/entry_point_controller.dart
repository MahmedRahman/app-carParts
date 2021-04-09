import 'dart:convert';

import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/modules/authiocation/provider/authiocation_provider.dart';
import 'package:carpart/app/modules/entry_point/providers/entry_point_provider.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:get/get.dart';

class EntryPointController extends GetxController {
  //TODO: Implement EntryPointController

  @override
  void onInit() async {
    // TODO: implement onInit
    if (Get.find<UserAuth>().getRole()?.toString() == null ||
        Get.find<UserAuth>().getUserEmail()?.toString() == null ||
        Get.find<UserAuth>().getUserName()?.toString() == null) {
      Get.find<UserAuth>().setRole(userRole.anonymous);
    }

    await getcity();
    await getcarMark();
    await getcarModel();
   // await getcarVersions();
    Get.toNamed(Routes.HOME);
    super.onInit();
  }

  Future getcity() async {
    Response response = await EntryPointProvider().getcity();
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
    Response response = await EntryPointProvider().getMark();
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
    Response response = await EntryPointProvider().getModel();
    print(response.bodyString);

    List<dynamic> ListData = jsonDecode(response.bodyString);

    ListData.forEach((element) {
      carModel.add({
        "id": "" + element['Id'].toString() + "",
        "title": "" + element['Name'].toString() + "",
      });
    });
  }


}
