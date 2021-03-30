import 'dart:convert';
import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';

String baes_url = 'https://carpart.atpnet.net/api/';

class RepostoryProvide extends GetConnect {
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
    print(baes_url  + url);
    setUserTokan();
    Response response = await post(baes_url  + url, body, headers: header);
    //print(response.bodyString);
    try {
      switch (response.statusCode) {
        case 200:
          return response;
          break;
        case 401:
          if (Get.find<UserAuth>().getRole() != userRole.anonymous) {
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
    print(baes_url +  url);
    setUserTokan();
    Response response = await get(baes_url + url, headers: header);
    //print(response.bodyString);
    try {
      switch (response.statusCode) {
        case 200:
          return response;
          break;
        case 401:
          if (Get.find<UserAuth>().getRole() != userRole.anonymous) {
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
}
