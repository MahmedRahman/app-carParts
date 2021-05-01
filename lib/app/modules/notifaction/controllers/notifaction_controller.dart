import 'package:carpart/app/api/response_model.dart';
import 'package:carpart/app/api/webServices.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/model/notifaction_model.dart';

import 'package:get/get.dart';

class NotifactionController extends GetxController {
  final notifactionList = Future.value().obs;

  //TODO: Implement NotifactionController
  getNotifaction() async {
    ResponsModel responsModel = await WebServices().getNotifaction();
    if (responsModel.success) {
      Response response = responsModel.data;
      final notifactionModel = notifactionModelFromJson(response.bodyString);
      notifactionList.value = Future.value(notifactionModel);
      return notifactionModel;
    }
  }

  setNotifactionRead(String notifactionId) async {
    ResponsModel responsModel =
        await WebServices().setNotifactionRead(notifactionId);
    if (responsModel.success) {
      Response response = responsModel.data;
      NotifactionCount.value = NotifactionCount.value - 1;
      getNotifaction();
    }
  }
}
