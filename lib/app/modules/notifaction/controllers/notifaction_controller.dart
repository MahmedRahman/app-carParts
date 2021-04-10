import 'package:carpart/app/data/webServices.dart';
import 'package:carpart/app/data/model/notifaction_model.dart';

import 'package:get/get.dart';

class NotifactionController extends GetxController {
  //TODO: Implement NotifactionController
  getNotifaction() async {
    Response response = await WebServices().getNotifaction();
    final notifactionModel = notifactionModelFromJson(response.bodyString);
    return notifactionModel;
  }
}
