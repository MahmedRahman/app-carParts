import 'dart:convert';

import 'package:carpart/app/api/ApiManger.dart';
import 'package:carpart/app/api/response_model.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/model/offer_model.dart';
import 'package:carpart/app/modules/profile/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class WebServices extends ApiManger {
  Future siginWithPhoneNumber({
    @required String phone,
    @required String password,
  }) async {
    EasyLoading.show(status: 'جارى التحميل');

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
      EasyLoading.showError(response.body['error_description']);
      return Future.error(response.body['error_description']);
    } else {
      EasyLoading.showSuccess('تم تسجيل الدخول');
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
    ResponsModel response = await repPost(
        'Account/Register',
        {
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
        },
        showLoading: true);

    return response;
  }

  Future<ResponsModel> upgrateMerchant(
      {@required String businessName,
      @required String registrationImageBytes}) async {
    ResponsModel response = await repPost(
        'Account/Upgrade?role=1',
        {
          "BusinessName": businessName,
          "RegistrationImageBytes": registrationImageBytes,
          "Lat": Klatitude,
          "Lng": Klongitude,
        },
        showLoading: true);
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

  Future<ResponsModel> setStatus({
    @required int orderId,
    @required int statusId,
  }) async {
    ResponsModel response = await repPost(
        'Order/SetStatus/' +
            orderId.toString() +
            '?status=' +
            statusId.toString(),
        {});
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
    ResponsModel response = await repPost(
        'Order/Add',
        {
          "MarkId": markid,
          "ModelId": modelId,
          "VersionId": versionId,
          "VanNumber": vanNumber,
          "Description": description,
          "ImageBytes": imageBytes.toString(),
          "Lat": Klatitude,
          "Lng": Klongitude,
        },
        showLoading: true);

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
       @required String image,
    
  }) async {
    ResponsModel response = await repPost('MerchantOffer/Add', {
      "OrderId": orderId,
      "Name": name,
      "Price": price,
      "ImageBytes" : image.toString()
    },showLoading: true);

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
    ResponsModel response = await repPost(
      'PaymentRequest/Add',
      {"Price": price},
      showLoading: true,
    );
    return response;
  }

  Future<ResponsModel> deleteOrder(String Orderid) async {
    ResponsModel response = await repPost('Order/Delete/$Orderid', {});
    return response;
  }

  Future<ResponsModel> addReview() async {
    ResponsModel response = await repPost('Review/Add/', {
      "MerchantId": "sample string 3",
      "DeliveryAgentId": "sample string 5",
      "MerchantRate": 7,
      "DeliveryAgentRate": 8,
    });
    return response;
  }

  Future<ResponsModel> addPaymentCard(
      String Brand,
      String CardNumber,
      String CardHolder,
      String ExpiryMonth,
      String ExpiryYear,
      String CVV,
      int OrderId) async {
    ResponsModel response = await repPost('Payment/Add', {
      "Brand": Brand,
      "CardNumber": CardNumber,
      "CardHolder": CardHolder,
      "ExpiryMonth": ExpiryMonth,
      "ExpiryYear": ExpiryYear,
      "CVV": CVV,
      "OrderId": OrderId,
    } ,showLoading: true);
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
    ResponsModel response = await repPost(
        'Account/Upgrade?role=2',
        {
          "NationalNumber": nationalNumber,
          "NationalIdBytes": nationalIdBytes,
          "DrivingLicenseBytes": drivingLicenseBytes,
          "CarFrontBytes": carFrontBytes,
          "CarBackBytes": carBackBytes,
          "CarPaperBytes": carPaperBytes
        },
        showLoading: true);
    return response;
  }

  Future<ResponsModel> getdistance({
    @required double originslat,
    @required double originslang,
    @required double destinationslat,
    @required double destinationslang,
  }) async {
    ResponsModel response = await repGet(
        'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$originslat,$originslang&destinations=$destinationslat,$destinationslang&key=AIzaSyC8ph0Arqdy0u0I5kEqV44sXFPUSM7iOb0&language=ar');
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
        'Account/Profile', profileModel.toJson(),
        showLoading: true);

    return response;


  }

  Future<ResponsModel> setRate({
    String orderId,
    String merchantRate,
    String deliveryRate,
  }) async {

    ResponsModel response = await repPost(
        'Order/SetRate',
        {
          "Id": orderId,
          "MerchantRate": merchantRate,
          "DeliveryRate": deliveryRate,
        },
        showLoading: true);
    return response;
  }

  Future<ResponsModel> setNotifactionRead(String notifactionid) async {
    ResponsModel response =
        await repPost('Account/SetRead/' + notifactionid.toString(), {});
    return response;
  }

  Future<ResponsModel> setForgotPassword(String phonenumber) async {
    ResponsModel response = await repPost(
        'Account/ForgotPassword?userName=' + phonenumber.toString(), {});
    return response;
  }

  Future<ResponsModel> setResetPassword(String phonenumber) async {
    ResponsModel response = await repPost('api/Account/ResetPassword', {
      "UserName": "sample string 1",
      "Password": "sample string 2",
      "ConfirmPassword": "sample string 3",
      "Code": "sample string 4"
    });
    return response;
  }




}
