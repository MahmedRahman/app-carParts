import 'package:carpart/app/data/model/bank_model.dart';
import 'package:carpart/app/data/webServices.dart';
import 'package:get/get.dart';

class BankListController extends GetxController {
  //TODO: Implement BankListController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future getUserBank() async {
    Response response = await WebServices().getUserBank();
    print(response.bodyString);
    final bankModel = bankModelFromJson(response.bodyString);
    return bankModel;
  }
}
