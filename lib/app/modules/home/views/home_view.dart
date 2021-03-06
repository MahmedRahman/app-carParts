import 'package:badges/badges.dart';
import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/component/CustomImageCached.dart';
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
import 'package:share/share.dart';

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
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: Kselectindex.value,
          backgroundColor: Colors.white70,
          selectedItemColor: KAccentColor,
          unselectedItemColor: KScandaryColor,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          type: BottomNavigationBarType.fixed,
          elevation: 2,
          onTap: (value) {
            if (KRole == userRole.anonymous) {
              Kselectindex.value = 0;
              AppUtils().showDialog(
                  AppName, '?????????? ?????????? ???????? ?????? ?????????? ???? ?????????????? ??????????????', () {
                Get.back();
                Get.toNamed(Routes.SigninView);
              });
            } else {
              Kselectindex.value = value;
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
                  color:
                      Kselectindex.value == 0 ? KAccentColor : KScandaryColor,
                ),
              ),
              label: '????????????????',
            ),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: SvgPicture.asset(
                    'images/menu/Cart.svg',
                    color:
                        Kselectindex.value == 1 ? KAccentColor : KScandaryColor,
                  ),
                ),
                label: '??????????????'),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: Obx(
                  () {
                    return Badge(
                      badgeContent: Text(
                        NotifactionCount.value.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          
                        ),
                      ),
                      
                      showBadge: NotifactionCount.value == 0 ? false : true,
                      
                      badgeColor: Colors.red,
                      child: SvgPicture.asset(
                        'images/menu/notifications.svg',
                        color: Kselectindex.value == 2
                            ? KAccentColor
                            : KScandaryColor,
                      ),
                    );
                  },
                ),
              ),
              label: '??????????????????',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: SvgPicture.asset(
                  'images/menu/Profile.svg',
                  color:
                      Kselectindex.value == 3 ? KAccentColor : KScandaryColor,
                ),
              ),
              label: '??????????',
            )
          ],
        );
      }),
      body: Obx(() {
        return _stack[Kselectindex.value];
      }),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                      child: Obx(
                        () {
                          return Center(
                            child: KRole != userRole.anonymous
                                ? Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width: 64,
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundImage:
                                              NetworkImage(KUserImage.value),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            KName.value,
                                            style: headline3.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            KEmail.value,
                                            style: headline3.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : SizedBox.shrink(),
                          );
                        },
                      ),
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
                        '????????????????',
                        style: headline4.copyWith(color: Colors.white),
                      ),
                      leading: SizedBox(
                        width: 32,
                        height: 32,
                        child: Image.asset('images/drwar/home.png'),
                      ),
                      onTap: () {
                        Kselectindex.value = 0;
                        Get.back();
                      },
                    ),
                    ListTile(
                      title: Text(
                        '???? ??????????????',
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
                        ListTile(
                      title: Text(
                        '???????????? ????????????????',
                        style: headline4.copyWith(color: Colors.white),
                      ),
                      leading: Image.asset('images/drwar/about.png'),
                      onTap: () {
                        Get.back();
                        Get.toNamed(
                          Routes.TREMSNEW,
                        );
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    SizedBox(
                        child: KRole == userRole.Client
                            ? ListTile(
                                title: Text(
                                  '?????? ???????????? ????????????',
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
                                  '?????? ???????????? ??????????',
                                  style:
                                      headline4.copyWith(color: Colors.white),
                                ),
                                leading: Image.asset('images/drwar/sign.png'),
                                onTap: () {
                                  Get.back();
                                  Get.toNamed(Routes.SignupDealerView);
                                },
                              )
                            : SizedBox.shrink()),
                    SizedBox(
                        child: KRole == userRole.anonymous
                            ? ListTile(
                                title: Text(
                                  '?????????? ????????',
                                  style: headline4.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                leading: Image.asset('images/drwar/sign.png'),
                                onTap: () {
                                  Get.back();
                                  Get.toNamed(Routes.AUTHIOCATION_SIGNUP);
                                },
                              )
                            : SizedBox.shrink()),
                    SizedBox(
                        child: KRole == userRole.anonymous
                            ? ListTile(
                                title: Text(
                                  '?????????? ????????????',
                                  style:
                                      headline4.copyWith(color: Colors.white),
                                ),
                                leading:
                                    SvgPicture.asset('images/drwar/login.svg'),
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
                        '???????????? ??????????????',
                        style: headline4.copyWith(color: Colors.white),
                      ),
                      leading: Image.asset('images/drwar/shareappmenu.png'),
                      onTap: () {
                        Share.share('check out my website https://tsp.sa');
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      title: Text(
                        '???????? ??????',
                        style: headline4.copyWith(color: Colors.white),
                      ),
                      leading: SvgPicture.asset('images/drwar/callus.svg'),
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.ContactusView);
                      },
                    ),
                    Container(
                      color: Color(0XFF445969),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: KRole != userRole.anonymous
                              ? ListTile(
                                  title: Text(
                                    '?????????? ????????',
                                    style:
                                        headline4.copyWith(color: Colors.white),
                                  ),
                                  leading: Image.asset('images/drwar/exit.png'),
                                  onTap: () {
                                    Get.back();
                                    KRole = userRole.anonymous;
                                    Get.find<UserAuth>().setUserToken(null);
                                    Kselectindex.value = 0;
                                    NotifactionCount.value = 0;
                                    Get.offAndToNamed(Routes.HOME);
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
        );
  }
}
