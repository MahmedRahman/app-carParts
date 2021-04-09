import 'package:carpart/app/data/repostory.dart';
import 'package:get/get.dart';

class ProviderProvider extends RepostoryProvide {
  Future getNotifaction() async {
    Response response = await repGet('Account/Notification');
    return response;
  }
}
