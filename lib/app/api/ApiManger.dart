import 'dart:convert';
import 'package:carpart/app/api/response_model.dart';
import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';

String baes_url = 'https://carpart.atpnet.net/api/';

class ApiManger extends GetConnect {
  final header = {
    'Authorization': 'Bearer ',
  };

  void login() {
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

  Future<ResponsModel> repPost(url, body) async {
    print("Api Request " + baes_url + url);
    login();

    Response response = await post(baes_url + url, body, headers: header);

    try {
      switch (response.statusCode) {
        case 200:
          return ResponsModel(
            code: response.statusCode,
            success: true,
            data: response,
          );
          break;

        default:
          Get.to(ErrorView(
            api_url: url.toString(),
            api_body: body.toString(),
            api_header: header.toString(),
            api_status_code: response.statusCode.toString(),
          ));
          return ResponsModel(
            code: response.statusCode,
            success: false,
          );
      }
    } catch (e) {
      Get.to(ErrorView(
        api_url: response.headers.toString(),
        api_body: e.toString(),
        api_header: '',
        api_status_code: e.hashCode.toString(),
      ));
      return ResponsModel(
        code: e.hashCode,
        success: false,
      );
    }
  }

  Future<ResponsModel> repGet(url) async {
    print("Api Request " + baes_url + url);
    login();
    Response response;
    if (GetUtils.isURL(url)) {
      response = await get(url, headers: header);
    } else {
      response = await get(baes_url + url, headers: header);
    }

    print("Api Request " +
        baes_url +
        url +
        " Api Request:: " +
        response.statusCode.toString());

    try {
      switch (response.statusCode) {
        case 200:
          return ResponsModel(
            code: response.statusCode,
            success: true,
            data: response,
          );
          break;

        default:
          Get.to(ErrorView(
            api_url: url.toString(),
            api_body: '',
            api_header: header.toString(),
            api_status_code: response.statusCode.toString(),
          ));
          return ResponsModel(
            code: response.statusCode,
            success: false,
          );
      }
    } catch (e) {
      Get.to(ErrorView(
        api_url: response.headers.toString(),
        api_body: e.toString(),
        api_header: '',
        api_status_code: e.hashCode.toString(),
      ));
      return ResponsModel(
        code: e.hashCode,
        success: false,
      );
    }
  }
}

class ErrorView extends GetView {
  ErrorView({
    this.api_url,
    this.api_header,
    this.api_body,
    this.api_status_code,
  });

  final String api_url;
  final String api_header;
  final String api_body;
  final String api_status_code;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            //Lottie.asset('assets/error_api.json'),
            ListTile(
              title: Text('API Url'),
              subtitle: Text(api_url),
            ),
            ListTile(
              title: Text('API Header'),
              subtitle: Text(api_header.toString()),
            ),
            ListTile(
              title: Text('API Body'),
              subtitle: Text(api_body.toString()),
            ),
            ListTile(
              title: Text('API Status Code'),
              subtitle: Text(api_status_code),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'أعادة المحاولة',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}