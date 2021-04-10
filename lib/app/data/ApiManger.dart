import 'dart:convert';
import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';

String baes_url = 'https://carpart.atpnet.net/api/';

class ApiManger extends GetConnect {
  final header = {
    'Authorization': 'Bearer ',
  };

  void setUserTokan() {
    String tokan = Get.find<UserAuth>().getUserToken();

    if (tokan != null) {
      header.update(
        'Authorization',
        (value) {
          return 'Bearer ' + tokan;
        },
      );
    }
  }

  Future<Response> repPost(url, body) async {
    print(baes_url + url);
    setUserTokan();
    Response response =
        await post(baes_url + url, json.encode(body), headers: header);
    print(baes_url + url + " statusCode " + response.statusCode.toString());
    try {
      switch (response.statusCode) {
        case 200:
          return response;
          break;
        case 401:
          if (KRole != userRole.anonymous) {
            Get.find<UserAuth>().signout();
          }
          return Future.error('error');
          break;
        default:
          return Future.error('error');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> repGet(url) async {
    print(baes_url + url);
    setUserTokan();

    Response response = await get(baes_url + url, headers: header);
    print(baes_url + url + " statusCode " + response.statusCode.toString());
    try {
      switch (response.statusCode) {
        case 200:
          return response;
          break;
        case 401:
        
          if (KRole != userRole.anonymous) {
            Get.find<UserAuth>().signout();
          }

        

          return Future.value(response);
          break;
        default:
          Get.toNamed(Routes.STOPERROR,arguments: [url ,response.statusCode.toString() ]);
          return Future.error('error');
      }
    } catch (e) {
      Get.toNamed(Routes.STOPERROR,arguments: [url ,response.statusCode.toString() ]);
      return Future.error(e);
    }
  }
}
