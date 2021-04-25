import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/component/MapSample.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/data/helper/AppUtils.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/modules/entry_point/bindings/entry_point_binding.dart';
import 'package:carpart/app/modules/entry_point/controllers/entry_point_controller.dart';
import 'package:carpart/app/modules/notifaction/views/notifaction_view.dart';
import 'package:carpart/app/modules/order/add/views/order_add_view.dart';
import 'package:carpart/app/modules/order/list/views/order_list_view.dart';

import 'package:carpart/app/modules/profile/views/profile_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:carpart/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  List<Widget> _stack = [
    OrderAddView(),
    OrderListView(),
    NotifactionView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: Get.width * .2,
          child: Image.asset(
            'images/logodark.png',
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: KPrimaryColor,
      ),
      drawer: Drawer(
          elevation: 0.0,
          child: Container(
            color: KScandaryColor,
            child: ListView(
              children: [
                KRole != userRole.anonymous
                    ? Container(
                        height: Get.height * .3,
                        decoration: BoxDecoration(
                          color: KScandaryColor,
                          image: DecorationImage(
                            image: AssetImage(
                              'images/drwar/wallpaper.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                            child: KRole != userRole.anonymous
                                ? ListTile(
                                    leading: Container(
                                      child:
                                          Image.asset('images/drwar/user.png'),
                                    ),
                                    title: Text(
                                      KName,
                                      style: headline3.copyWith(
                                          color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      KEmail,
                                      style: headline3.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink()),
                      )
                    : Container(
                        height: Get.height * .3,
                        decoration: BoxDecoration(
                          color: KScandaryColor,
                          image: DecorationImage(
                            image: AssetImage(
                              'images/drwar/wallpaper.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            'images/logolight.png',
                            width: 128,
                          ),
                        ),
                      ),
                Container(
                  height: Get.height * .6,
                  color: Color(0XFF445969),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'الرئيسية',
                          style: headline4.copyWith(color: Colors.white),
                        ),
                        leading: SizedBox(
                          width: 32,
                          height: 32,
                          child: Image.asset('images/drwar/home.png'),
                        ),
                        onTap: () {
                          Get.find<HomeController>().selectindex.value = 0;
                          Get.back();
                        },
                      ),
                      ListTile(
                        title: Text(
                          'عن التطبيق',
                          style: headline4.copyWith(color: Colors.white),
                        ),
                        leading: Image.asset('images/drwar/about.png'),
                        onTap: () {
                          Get.back();
                          Get.toNamed(
                            Routes.AboutView,
                          );
                          // Update the state of the app.
                          // ...
                        },
                      ),
                      SizedBox(
                          child: KRole == userRole.Client
                              ? ListTile(
                                  title: Text(
                                    'طلب انضمام كمندوب',
                                    style:
                                        headline4.copyWith(color: Colors.white),
                                  ),
                                  leading: Image.asset('images/drwar/sign.png'),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.SignupDeliveryView);
                                    // Update the state of the app.
                                    // ...
                                  },
                                )
                              : SizedBox.shrink()),
                      SizedBox(
                          child: KRole == userRole.Client
                              ? ListTile(
                                  title: Text(
                                    'طلب انضمام كتاجر',
                                    style:
                                        headline4.copyWith(color: Colors.white),
                                  ),
                                  leading: Image.asset('images/drwar/sign.png'),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.SignupDealerView);
                                    // Update the state of the app.
                                    // ...
                                  },
                                )
                              : SizedBox.shrink()),
                      SizedBox(
                          child: KRole == userRole.anonymous
                              ? ListTile(
                                  title: Text(
                                    'تسجيل جديد',
                                    style:
                                        headline4.copyWith(color: Colors.white),
                                  ),
                                  leading: Image.asset('images/drwar/sign.png'),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.SignupView);

                                    // Get.to(SigninView(), fullscreenDialog: true);

                                    // Update the state of the app.
                                    // ...
                                  },
                                )
                              : SizedBox.shrink()),
                      SizedBox(
                          child: KRole == userRole.anonymous
                              ? ListTile(
                                  title: Text(
                                    'تسجيل الدخول',
                                    style:
                                        headline4.copyWith(color: Colors.white),
                                  ),
                                  leading: SvgPicture.asset(
                                      'images/drwar/login.svg'),
                                  onTap: () {
                                    Get.back();
                                    // Get.to()
                                    Get.offNamed(Routes.SigninView);
                                    // Update the state of the app.
                                    // ...
                                  },
                                )
                              : SizedBox.shrink()),
                      ListTile(
                        title: Text(
                          'مشاركة التطبيق',
                          style: headline4.copyWith(color: Colors.white),
                        ),
                        leading: Image.asset('images/drwar/shareappmenu.png'),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                        },
                      ),
                      ListTile(
                        title: Text(
                          'اتصل بنا',
                          style: headline4.copyWith(color: Colors.white),
                        ),
                        leading: SvgPicture.asset('images/drwar/callus.svg'),
                        onTap: () {
                          Get.back();
                          Get.toNamed(Routes.ContactusView);
                          // Update the state of the app.
                          // ...
                        },
                      ),
                      Container(
                        color: Color(0XFF445969),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: KRole != userRole.anonymous
                                ? ListTile(
                                    title: Text(
                                      'تسجيل خروج',
                                      style: headline4.copyWith(
                                          color: Colors.white),
                                    ),
                                    leading:
                                        Image.asset('images/drwar/exit.png'),
                                    onTap: () {
                                      Get.back();

                                      KRole = userRole.anonymous;

                                      Get.find<UserAuth>().setUserToken(null);
controller.selectindex.value =0;
                                      Get.offAndToNamed(Routes.HOME);

                                      // Get.find<UserAuth>().signout();
                                    },
                                  )
                                : SizedBox.shrink()),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: SizedBox.shrink(),
                )
              ],
            ),
          ) // Populate the Drawer in the next step.
          ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.selectindex.value,
          backgroundColor: Colors.white70,
          selectedItemColor: KAccentColor,
          unselectedItemColor: KScandaryColor,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          type: BottomNavigationBarType.fixed,
          elevation: 2,
          onTap: (value) {
            if (KRole == userRole.anonymous) {
              controller.selectindex.value = 0;
              AppUtils().showDialog(
                  AppName, 'برجاء تسجيل دخول حتى تتمكن من استخدام التطبيق', () {
                Get.back();
                Get.toNamed(Routes.SigninView);
              });
            } else {
              controller.selectindex.value = value;
              // _stack[value];
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: SvgPicture.asset(
                  'images/menu/Home.svg',
                  color: controller.selectindex.value == 0
                      ? KAccentColor
                      : KScandaryColor,
                ),
              ),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: SvgPicture.asset(
                    'images/menu/Cart.svg',
                    color: controller.selectindex.value == 1
                        ? KAccentColor
                        : KScandaryColor,
                  ),
                ),
                label: 'الطلبات'),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: SvgPicture.asset(
                  'images/menu/notifications.svg',
                  color: controller.selectindex.value == 2
                      ? KAccentColor
                      : KScandaryColor,
                ),
              ),
              label: 'التنبيهات',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: SvgPicture.asset(
                  'images/menu/Profile.svg',
                  color: controller.selectindex.value == 3
                      ? KAccentColor
                      : KScandaryColor,
                ),
              ),
              label: 'صفحتي',
            )
          ],
        );
      }),
      body: Obx(() {
        return _stack[controller.selectindex.value];
      }),
    );
  }
}
