import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/data/helper/AppUtils.dart';
import 'package:carpart/app/modules/entry_point/bindings/entry_point_binding.dart';
import 'package:carpart/app/modules/entry_point/controllers/entry_point_controller.dart';
import 'package:carpart/app/modules/notifaction/views/notifaction_view.dart';
import 'package:carpart/app/modules/order/views/order_create_view.dart';
import 'package:carpart/app/modules/order/views/order_view.dart';
import 'package:carpart/app/modules/profile/views/profile_view.dart';
import 'package:carpart/app/routes/app_pages.dart';

import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemCheckbox.dart';
import 'package:carpart/app/data/component/CustemDropdown__.dart';
import 'package:carpart/app/data/component/CustemIconButton.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:carpart/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  var selectindex = 0.obs;
  userRole currentUser = Get.find<UserAuth>().getRole();
  @override
  Widget build(BuildContext context) {
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
                Container(
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
                    child:Get.find<UserAuth>().getRole() != userRole.anonymous ? ListTile(
                      leading: Container(
                        child: Image.asset('images/drwar/user.png'),
                      ),
                      title: Text(
                        Get.find<UserAuth>().getUserName(),
                        style: headline3.copyWith(color: Colors.white),
                      ),
                      subtitle: Text(
                          Get.find<UserAuth>().getUserEmail(),
                        style: headline3.copyWith(color: Colors.white),
                      ),
                    ):SizedBox.shrink()
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
                          Get.toNamed(Routes.AboutView);
                          // Update the state of the app.
                          // ...
                        },
                      ),
                      SizedBox(
                          child: Get.find<UserAuth>().getRole() == userRole.Buyer
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
                          child: Get.find<UserAuth>().getRole() == userRole.Buyer
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
                          child: Get.find<UserAuth>().getRole() ==
                                  userRole.anonymous
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
                                    // Update the state of the app.
                                    // ...
                                  },
                                )
                              : SizedBox.shrink()),
                      SizedBox(
                          child: Get.find<UserAuth>().getRole() ==
                                  userRole.anonymous
                              ? ListTile(
                                  title: Text(
                                    'تسجيل الدخول',
                                    style:
                                        headline4.copyWith(color: Colors.white),
                                  ),
                                  leading:
                                      SvgPicture.asset('images/drwar/login.svg'),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.SigninView);
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
                            child: currentUser != userRole.anonymous
                                ? ListTile(
                                    title: Text(
                                      'تسجيل خروج',
                                      style:
                                          headline4.copyWith(color: Colors.white),
                                    ),
                                    leading: Image.asset('images/drwar/exit.png'),
                                    onTap: () {
                                      // Update the state of the app.
                                      Get.back();
                                      Get.find<UserAuth>()
                                          .signout();
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
          currentIndex: selectindex.value,
          selectedItemColor: KAccentColor,
          unselectedItemColor: KScandaryColor,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          type: BottomNavigationBarType.fixed,
          elevation: 2,
          onTap: (value) {
            if (Get.find<UserAuth>().getRole() == userRole.anonymous) {
              selectindex.value = 0;
              AppUtils().showDialog(
                  AppName, 'برجاء تسجيل دخول حتى تتمكن من استخدام التطبيق', () {
                Get.back();
                Get.toNamed(Routes.SigninView);
              });
            } else {
              selectindex.value = value;
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
                  color: selectindex.value == 0 ? KAccentColor : KScandaryColor,
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
                    color:
                        selectindex.value == 1 ? KAccentColor : KScandaryColor,
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
                  color: selectindex.value == 2 ? KAccentColor : KScandaryColor,
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
                  color: selectindex.value == 3 ? KAccentColor : KScandaryColor,
                ),
              ),
              label: 'صفحتي',
            )
          ],
        );
      }),
      body: Obx(() {
        return IndexedStack(
          index: selectindex.value,
          children: [
            OrderCreateView(),
            OrderView(),
            NotifactionView(),
            ProfileView(),
            AnonymousUser()
          ],
        );
      }),
    );
  }
}



class AnonymousUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('برجاء تسجيل الدخول'),
    );
  }
}
