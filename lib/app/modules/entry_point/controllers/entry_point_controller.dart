import 'dart:convert';

import 'package:carpart/app/api/response_model.dart';
import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/model/PrepareListModel.dart';
import 'package:carpart/app/data/model/setting_model.dart';
import 'package:carpart/app/api/webServices.dart';

import 'package:carpart/app/routes/app_pages.dart';
import 'package:carpart/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class EntryPointController extends GetxController {
  //TODO: Implement EntryPointController

  @override
  void onInit() async {
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;

      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        Get.snackbar(notification.title, notification.body);

        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android?.smallIcon,
              ),
            ));
      }
    });
    getToken();
  }

  getToken() async {
    String token = await FirebaseMessaging.instance.getToken();
    KFirebaseMessagingToken = token;
  }

  void Start() async {
    await fillLookUpTable().then((value) {
      Get.offNamed(Routes.HOME);
    });

    super.onInit();
  }

  Future fillLookUpTable() async {
    await getprepareList();

    if (GetUtils.isNullOrBlank(Get.find<UserAuth>().getUserToken())) {
      KRole = userRole.anonymous;
    } else {
      await getProfile();
    }

    //if (KRole != userRole.anonymous) {

    // }
  }

  Future getprepareList() async {
    ResponsModel responsModel = await WebServices().getprepareList();
    if (responsModel.success) {
      Response response = responsModel.data;

      final prepareListModel = prepareListModelFromJson(response.bodyString);

      prepareListModel.cities.forEach((element) {
        cityName.add({
          "id": "" + element.id.toString() + "",
          "title": "" + element.name + "",
        });
      });

      prepareListModel.bank.forEach((element) {
        bankName.add({
          "id": "" + element.id.toString() + "",
          "title": "" + element.name.toString() + "",
        });
      });

      pageAbout = Future.value(prepareListModel.setting.about);
      pageCallus = Future.value(prepareListModel.setting.callUs);
      pageTream = Future.value(prepareListModel.setting.terms);

      KMPriceMin = prepareListModel.setting.kmPriceMin;
      KMPriceMax = prepareListModel.setting.kmPriceMax;
      helpPhoneNumber = prepareListModel.setting.helpPhoneNumber;
      BaseDeliveryPrice = prepareListModel.setting.BaseDeliveryPrice;

      KAdministrativeFees = prepareListModel.setting.AdministrativeFees;
      print(BaseDeliveryPrice);

      Cars.addAll(prepareListModel.mark);
    }
  }

  Future getProfile() async {
    ResponsModel responsModel = await WebServices().getProfile();
    if (responsModel.success) {
      Response response = responsModel.data;

      KName = response.body['Name'];
      KEmail = response.body['Email'];
      KCity = response.body['CityName'];

      Klatitude = response.body['Lat'];
      Klongitude = response.body['Lng'];
      KBalance = response.body['Balance'];

      KPaidBalance = response.body['PaidBalance'];

      KRole = userRole.values[response.body['Role']];

      KUserImage = 'https://carpart.atpnet.net/Files/Merchant/' +
          response.body['Id'].toString() +
          '/' +
          response.body['RegistrationImage'].toString();
    }
  }
}
