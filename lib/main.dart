import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/data/helper/AppTranslation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await initServices();

  runApp(
    GetMaterialApp(
      title: AppName,
      theme: themeData,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      locale: Locale('ar', 'EG'),
      fallbackLocale: Locale('ar', 'EG'),
      translations: AppTranslation(),
    ),
  );
}

void initServices() async {
  await Get.putAsync<UserAuth>(() async => await UserAuth());
}
