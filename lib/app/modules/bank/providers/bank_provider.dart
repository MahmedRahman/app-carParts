import 'package:carpart/app/data/repostory.dart';
import 'package:get/get.dart';

class BankProvider extends RepostoryProvide {

Future getUserBank() async{
  return await repGet('UserBank/Get').then((Response response) {
    return response;
  });



  
}
}
