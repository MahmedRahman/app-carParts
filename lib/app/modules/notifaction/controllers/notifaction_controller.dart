import 'package:carpart/app/modules/notifaction/model/notifaction_model.dart';
import 'package:carpart/app/modules/notifaction/providers/provider_provider.dart';
import 'package:get/get.dart';

class NotifactionController extends GetxController {
  //TODO: Implement NotifactionController

  getNotifaction() async {
    Response response = await ProviderProvider().getNotifaction();
    final notifactionModel = notifactionModelFromJson(response.bodyString);

    return notifactionModel;
  }
}
