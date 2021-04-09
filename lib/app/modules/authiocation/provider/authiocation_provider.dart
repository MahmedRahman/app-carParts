import 'package:carpart/app/data/repostory.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthiocationProvider extends RepostoryProvide {
  Future<Response> createUser({
    @required String name,
    @required String phoneNumber,
    @required String password,
    @required String email,
    @required int cityid,
    @required String DeviceId,
    String LogoBytes,
  }) async {

    Response response = await repPost('Account/Register', {
      "Name": name,
      "PhoneNumber": phoneNumber,
      "UserName": phoneNumber,
      "Password": password,
      "ConfirmPassword": password,
      "Email": email,
      "LogoBytes": LogoBytes,
      "CityId": cityid,
      "Lat": 9.1,
      "Lng": 10.1,
      "DeviceId": DeviceId
    });

    return response;
  }

  Future siginWithPhoneNumber({
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

  Future<Response> upgrateMerchant(
      {@required String businessName,
      @required String registrationImageBytes}) async {
        
    var data = {
      "BusinessName": businessName,
      "RegistrationImageBytes": registrationImageBytes
    };

    Response response = await repPost('Account/Upgrade?role=1', data);
    return response;
    //Account/Upgrade?role=1
  }
}
