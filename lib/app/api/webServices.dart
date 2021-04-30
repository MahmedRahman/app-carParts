import 'dart:convert';

import 'package:carpart/app/api/ApiManger.dart';
import 'package:carpart/app/api/response_model.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/model/offer_model.dart';
import 'package:carpart/app/modules/profile/model/profile_model.dart';
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

  Future<ResponsModel> createUser({
    @required String name,
    @required String phoneNumber,
    @required String password,
    @required String email,
    @required int cityid,
    @required String deviceId,
    String logoBytes,
  }) async {
    ResponsModel response = await repPost('Account/Register', {
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

  Future<ResponsModel> upgrateMerchant(
      {@required String businessName,
      @required String registrationImageBytes}) async {
    ResponsModel response = await repPost('Account/Upgrade?role=1', {
      "BusinessName": businessName,
      "RegistrationImageBytes": registrationImageBytes,
      "Lat": Klatitude,
      "Lng": Klongitude,
    });
    return response;
  }

  Future<ResponsModel> getcity() async {
    ResponsModel response = await repGet('City/Get');
    return response;
  }

  Future<ResponsModel> sendSms(String phoneNumber) async {
    ResponsModel response = await repPost('Home/SendSms/' + phoneNumber, {});
    return response;
  }

  Future<ResponsModel> setDeviceId(String deviceId) async {
    ResponsModel response =
        await repPost('Account/SetDeviceId/', {'id': deviceId});
    return response;
  }

  Future<ResponsModel> setLocation({
    @required int orderid,
    @required double lat,
    @required double lng,
  }) async {
    ResponsModel response =
        await repPost('Order/SetLocation/$orderid?lat=$lat&lng=$lng', '');
    return response;
  }

  Future<ResponsModel> getprepareList() async {
    ResponsModel response = await repGet('Setting/FullGet');
    return response;
  }

  Future<ResponsModel> getMark() async {
    ResponsModel response = await repGet('Mark/Get');
    return response;
  }

  Future<ResponsModel> getModel() async {
    ResponsModel response = await repGet('Model/Get');
    return response;
  }

  Future<ResponsModel> setPaid({
    @required int orderId,
  }) async {
    ResponsModel response =
        await repPost('Order/SetPaid/' + orderId.toString(), {});
    return response;
  }

  Future<ResponsModel> addDeliveryOffer({
    @required int orderId,
    @required double price,
  }) async {
    ResponsModel response = await repPost('DeliveryOffer/Add', {
      "OrderId": orderId,
      "Price": price,
    });
    return response;
  }

  Future<ResponsModel> getNotifaction() async {
    ResponsModel response =
        await repGet('Account/Notification', showLoading: false);
    return response;
  }

  Future<ResponsModel> createorder({
    @required int markid,
    @required int modelId,
    @required String versionId,
    @required String vanNumber,
    @required String description,
    String imageBytes,
  }) async {
    ResponsModel response = await repPost('Order/Add', {
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

  Future<ResponsModel> getOrder() async {
    ResponsModel response = await repGet('Order/Get', showLoading: false);
    return response;
  }

  Future<ResponsModel> getOrderDetailes(int OrderId) async {
    ResponsModel response =
        await repGet('Order/Get/$OrderId', showLoading: false);
    return response;
  }

  Future<ResponsModel> addOffer({
    @required int orderId,
    @required String name,
    @required double price,
  }) async {
    ResponsModel response = await repPost('MerchantOffer/Add', {
      "OrderId": orderId,
      "Name": name,
      "Price": price,
    });

    return response;
  }

  Future<ResponsModel> getMerchantOffers(int OrderId) async {
    ResponsModel response =
        await repGet('MerchantOffer/Getall/' + OrderId.toString());
    return response;
  }

  Future<ResponsModel> acceptOffer(int offerid) async {
    ResponsModel response =
        await repPost('MerchantOffer/Accept/' + offerid.toString(), null);
    return response;
  }

  Future<ResponsModel> acceptDeliveryOffer(int offerid) async {
    ResponsModel response =
        await repPost('DeliveryOffer/Accept/' + offerid.toString(), null);
    return response;
  }

  Future<ResponsModel> addUserBank(int bankId, String iBAN) async {
    ResponsModel response =
        await repPost('UserBank/Add', {"BankId": bankId, "IBAN": iBAN});
    return response;
  }

  Future<ResponsModel> getBank() async {
    ResponsModel response = await repGet('Bank/Get');
    return response;
  }

  Future<ResponsModel> getUserBank() async {
    ResponsModel response = await repGet('UserBank/Get');
    return response;
  }

  Future<ResponsModel> addPaymentRequest(int price) async {
    ResponsModel response =
        await repPost('PaymentRequest/Add', {"Price": price});
    return response;
  }

  Future<ResponsModel> getPaymentRequest() async {
    ResponsModel response = await repGet('PaymentRequest/Get');
    return response;
  }

  Future<ResponsModel> getSetting() async {
    ResponsModel response = await repGet('Setting/Get');
    return response;
  }

  Future<ResponsModel> getProfile() async {
    ResponsModel response = await repGet('Account/GetProfile');
    return response;
  }

  Future<ResponsModel> upgrateDelivery({
    @required String nationalNumber,
    @required String nationalIdBytes,
    @required String drivingLicenseBytes,
    @required String carFrontBytes,
    @required String carBackBytes,
    @required String carPaperBytes,
  }) async {
    ResponsModel response = await repPost('Account/Upgrade?role=2', {
      "NationalNumber": nationalNumber,
      "NationalIdBytes": nationalIdBytes,
      "DrivingLicenseBytes": drivingLicenseBytes,
      "CarFrontBytes": carFrontBytes,
      "CarBackBytes": carBackBytes,
      "CarPaperBytes": carPaperBytes
    });
    return response;
  }

  Future<ResponsModel> getdistance({
    @required double originslat,
    @required double originslang,
    @required double destinationslat,
    @required double destinationslang,
  }) async {
    ResponsModel response = await repGet(
        'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$originslat,$originslang&destinations=$destinationslat,$destinationslang&key=AIzaSyC8ph0Arqdy0u0I5kEqV44sXFPUSM7iOb0');
    return response;
  }

  Future<ResponsModel> getplace({
    @required String address,
  }) async {
    ResponsModel response = await repGet(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$address&types=address&language=ar&key=AIzaSyC8ph0Arqdy0u0I5kEqV44sXFPUSM7iOb0');
    return response;
  }

  Future<ResponsModel> addMultiOffer(List<OfferModel> offerMultiList) async {
    String jsonTags = jsonEncode(offerMultiList);

    ResponsModel response = await repPost('MerchantOffer/AddMulti', jsonTags);

    return response;
  }

  Future<ResponsModel> isPhonelExist(String phone) async {
    ResponsModel response =
        await repPost('Account/PhonelExist?phone=$phone', {});
    return response;
  }

  Future<ResponsModel> setProfile(ProfileModel profileModel) async {
    ResponsModel response = await repPost(
      'Account/Profile',
      profileModel.toJson(),
    );
    return response;
  }
}
