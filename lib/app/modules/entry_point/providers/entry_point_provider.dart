import 'package:carpart/app/data/repostory.dart';
import 'package:get/get.dart';

class EntryPointProvider extends RepostoryProvide {
  Future getcity() async {
    return await repGet('City/Get').then((response) {
      return response;
    });
  }
}
