import 'package:carpart/app/data/ApiManger.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebServices extends ApiManger {
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
    if (response.status.hasError) {
      return Future.error(response.body['error_description']);
    } else {
      return response.bodyString.toString();
    }
  }

  Future createUser({
    @required String name,
    @required String phoneNumber,
    @required String password,
    @required String email,
    @required int cityid,
    @required String deviceId,
    String logoBytes,
  }) async {
    Response response = await repPost('Account/Register', {
      "Name": name,
      "PhoneNumber": phoneNumber,
      "UserName": phoneNumber,
      "Password": password,
      "ConfirmPassword": password,
      "Email": email,
      "LogoBytes": logoBytes,
      "CityId": cityid,
      "Lat": 9.1,
      "Lng": 10.1,
      "DeviceId": deviceId
    });

    return response;
  }

  Future upgrateMerchant(
      {@required String businessName,
      @required String registrationImageBytes}) async {
    Response response = await repPost('Account/Upgrade?role=1', {
      "BusinessName": businessName,
      "RegistrationImageBytes": registrationImageBytes,
      "Lat": Klatitude,
      "Lng": Klongitude,
    });
    return response;
  }

  Future getcity() async {
    Response response = await repGet('City/Get');
    return response;
  }

  Future setDeviceId(String deviceId) async {
    Response response =
        await repPost('Account/SetDeviceId/', {
          'id' : deviceId
        });
    return response;
  }

  Future getprepareList() async {
    Response response = await repGet('Setting/FullGet');
    return response;
  }

  Future getMark() async {
    Response response = await repGet('Mark/Get');
    return response;
  }

  Future getModel() async {
    Response response = await repGet('Model/Get');
    return response;
  }

  Future setPaid({@required int orderId,}) async {
    Response response = await repPost('Order/SetPaid/' + orderId.toString(),{});
    return response;
  }
  

  Future addDeliveryOffer({
    @required int orderId,
    @required double price,
  }) async {
    Response response = await repPost('DeliveryOffer/Add', {
      "OrderId": orderId,
      "Price": price,
    });
    return response;
  }

  Future getNotifaction() async {
    Response response = await repGet('Account/Notification');
    return response;
  }

  Future createorder({
    @required int markid,
    @required int modelId,
    @required String versionId,
    @required String vanNumber,
    @required String description,
    String imageBytes,
  }) async {
    Response response = await repPost('Order/Add', {
      "MarkId": markid,
      "ModelId": modelId,
      "VersionId": versionId,
      "VanNumber": vanNumber,
      "Description": description,
      "ImageBytes": imageBytes.toString(),
      "Lat": Klatitude,
      "Lng": Klongitude,
    });

    return response;
  }

  Future getOrder() async {
    Response response = await repGet('Order/Get');
    return response;
  }

  Future getOrderDetailes(int OrderId) async {
    Response response = await repGet('Order/Get/$OrderId');
    return response;
  }

  Future addOffer({
    @required int orderId,
    @required String name,
    @required double price,
  }) async {
    Response response = await repPost('MerchantOffer/Add', {
      "OrderId": orderId,
      "Name": name,
      "Price": price,
    });

    return response;
  }

  Future getMerchantOffers(int OrderId) async {
    Response response =
        await repGet('MerchantOffer/Getall/' + OrderId.toString());
    return response;
  }

  Future acceptOffer(int offerid) async {
    Response response =
        await repPost('MerchantOffer/Accept/' + offerid.toString(), null);
    return response;
  }

  Future acceptDeliveryOffer(int offerid) async {
    Response response =
        await repPost('DeliveryOffer/Accept/' + offerid.toString(), null);
    return response;
  }

  Future addUserBank(int bankId, String iBAN) async {
    Response response =
        await repPost('UserBank/Add', {"BankId": bankId, "IBAN": iBAN});
    return response;
  }

  Future getBank() async {
    Response response = await repGet('Bank/Get');
    return response;
  }

  Future getUserBank() async {
    Response response = await repGet('UserBank/Get');
    return response;
  }

  Future addPaymentRequest(int price) async {
    Response response = await repPost('PaymentRequest/Add', {"Price": price});
    return response;
  }

  Future getPaymentRequest() async {
    Response response = await repGet('PaymentRequest/Get');
    return response;
  }

  Future getSetting() async {
    Response response = await repGet('Setting/Get');
    return response;
  }

  Future getProfile() async {
    Response response = await repGet('Account/GetProfile');
    return response;
  }

  Future upgrateDelivery({
    @required String nationalNumber,
    @required String nationalIdBytes,
    @required String drivingLicenseBytes,
    @required String carFrontBytes,
    @required String carBackBytes,
    @required String carPaperBytes,
  }) async {
    Response response = await repPost('Account/Upgrade?role=2', {
      "NationalNumber": nationalNumber,
      "NationalIdBytes": nationalIdBytes,
      "DrivingLicenseBytes": drivingLicenseBytes,
      "CarFrontBytes": carFrontBytes,
      "CarBackBytes": carBackBytes,
      "CarPaperBytes": carPaperBytes
    });
    return response;
  }
}
