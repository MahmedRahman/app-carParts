import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/data/helper/AppTranslation.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'app/modules/entry_point/controllers/connectivity.dart';
import 'app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print(message.data['orderId']);
/*
  Get.snackbar(AppName, message.data['body'], onTap: (val) {
    Get.toNamed(Routes.ORDER_DETAIL, arguments: [message.data['orderId']]);
  });
*/
/*
  if (GetUtils.isNullOrBlank(message.data['body'])) {
  } else {
    print('Handling a background message ${message.messageId}');
    print(message.data['name']);
    flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
        ),
      ),
    );
    Get.snackbar(AppName, message.data['body']);
  }
*/
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
 // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await initServices();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: true,
      title: AppName,
      theme: themeData,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      locale: Locale('ar', 'EG'),
      fallbackLocale: Locale('ar', 'EG'),
      translations: AppTranslation(),
      builder: EasyLoading.init(),
    ),
  );
  //configLoading();
}

void initServices() async {
  await Get.putAsync<UserAuth>(() async => await UserAuth());
  await Get.putAsync<connectivity>(() async => await connectivity());
}
