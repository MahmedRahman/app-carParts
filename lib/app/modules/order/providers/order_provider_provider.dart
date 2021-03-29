import 'package:get/get.dart';

class OrderProviderProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
