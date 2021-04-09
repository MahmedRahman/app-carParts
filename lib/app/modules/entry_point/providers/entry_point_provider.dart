import 'package:carpart/app/data/repostory.dart';
import 'package:get/get.dart';

class EntryPointProvider extends RepostoryProvide {
  Future getcity() async {
    return await repGet('City/Get').then((response) {
      return response;
    });
  }

  Future getMark() async {
    return await repGet('Mark/Get').then((response) {
      return response;
    });
  }


  Future getModel() async {
    return await repGet('Model/Get').then((response) {
      return response;
    });
  }

  Future getVersion() async {
    return await repGet('Version/Get').then((response) {
      return response;
    });
  }
}
