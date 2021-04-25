import 'package:carpart/app/api/response_model.dart';
import 'package:carpart/app/data/model/bank_model.dart';
import 'package:carpart/app/api/webServices.dart';
import 'package:get/get.dart';

class BankListController extends GetxController {
  //TODO: Implement BankListController
  //Future bankModel = List<BankModel>.empty().obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future getUserBank() async {
    ResponsModel responsModel = await WebServices().getUserBank();
    if (responsModel.success) {
      Response response = responsModel.data;
      final bankModel = bankModelFromJson(response.bodyString);
      return bankModel;
    }
  }
}
