import 'package:carpart/app/modules/bank/providers/bank_provider.dart';
import 'package:get/get.dart';

class BankController extends GetxController {
  //TODO: Implement BankController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

Future getUserBank() async {
 return await BankProvider().getUserBank().then((Response) {

  });
}

}
