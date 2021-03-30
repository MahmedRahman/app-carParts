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
  void onInit() {
    // TODO: implement onInit
    if (Get.find<UserAuth>().getRole()?.toString() == null ||
        Get.find<UserAuth>().getUserEmail()?.toString() == null ||
        Get.find<UserAuth>().getUserName()?.toString() == null) {
      Get.find<UserAuth>().setRole(userRole.anonymous);
    }
    Future.delayed(Duration(seconds: 3), () {
      Get.toNamed(Routes.HOME);
    });

    getcity();
    super.onInit();
  }

  getcity() async {
    Response response = await EntryPointProvider().getcity();
    print(response.bodyString);

    List<dynamic> ListCity = jsonDecode(response.bodyString);

    ListCity.forEach((element) {
      CityName.add({
        "id": "" + element['Id'].toString() + "",
        "title": "" + element['Name'].toString() + "",
      });
    });

/*
     print(element['Name'].toString());
   staticDataModel.data.elementAt(0).diagnostics.forEach((element) {
        Diagnosis.add({
          "id": "" + element.id.toString() + "",
          "title": "" + element.title.toString() + "",
        });
      });
      */
  }
}
