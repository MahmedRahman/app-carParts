import 'package:carpart/app/data/repostory.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthiocationProvider extends RepostoryProvide {
  Future<Response> createUser({
    @required String name,
    @required String phoneNumber,
    @required String password,
    @required String email,
  }) async {
    Response response = await repPost('Account/Register', {
      "Name": name,
      "PhoneNumber": phoneNumber,
      "UserName": phoneNumber,
      "Password": password,
      "ConfirmPassword": password,
      "Email": email,
      "Logo": "sample string 12",
      "LogoFile": null,
      "CityId": 1,
      "Lat": 9.1,
      "Lng": 10.1,
      "DeviceId": "sample string 11"
    });

    return response;
  }

  siginWithPhoneNumber({
    @required String phone,
    @required String password,
  }) async {
    var data = {
      "username": phone,
      "password": password,
      "grant_type": "password"
    };

    var parts = [];

    data.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });

    var formData = parts.join('&');

    Response response = await post('https://carpart.atpnet.net/token', formData,
        headers: <String, String>{
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        });

    print(response.bodyString);
    if (response.status.hasError) {
      //print(response.body['error_description']);
      return Future.error(response.body['error_description']);
    } else {
      return response.bodyString.toString();
    }
  }
}
