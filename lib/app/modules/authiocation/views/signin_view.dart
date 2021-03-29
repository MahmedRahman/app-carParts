import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/data/helper/AppUtils.dart';
import 'package:carpart/app/data/helper/AppValidation.dart';
import 'package:carpart/app/modules/authiocation/controllers/authiocation_controller.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninView extends GetView<AuthiocationController> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AuthiocationHeader(
                  title: 'تسجيل دخول',
                ),
                Container(
                  height: Get.height * .35,
                  child: Column(
                    children: [
                      Container(
                        width: Get.width,
                        child: Row(
                          children: [
                            Container(
                              width: Get.width * .7,
                              decoration: BoxDecoration(color: Colors.white),
                              child: ListTile(
                                title: Text('رقم الجوال'),
                                subtitle: TextFormField(
                                  controller: controller.phoneNumber,
                                  decoration: InputDecoration(
                                    isDense: true,
                                  ),
                                  validator: (value) {
                                    return AppValidation.checkMobile(value);
                                  },
                                ),
                                leading: Icon(Icons.person),
                              ),
                            ),
                            Container(
                              width: Get.width * .3,
                              child: ListTile(
                                title: Text('السعودية'),
                                subtitle: Text('0096'),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Text('كلمة المرور'),
                          subtitle: TextFormField(
                            controller: controller.password,
                            decoration: InputDecoration(
                              isDense: true,
                            ),
                            validator: (value) {
                              return AppValidation.validatePassword(value);
                            },
                          ),
                          leading: Icon(Icons.lock),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.FrogatepasswordView,
                              );
                            },
                            child: Text(
                              'نسيت كلمة المرور ؟',
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustemButton(
                  title: 'تسجيل دخول',
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      controller.siginWithPhoneNumber();
                    }

                    /*
                    AppUtils().showSnackBar(
                        AppName, 'لقد قمت بالتسجيل انت الان تتمتع بصلاحيات المشترى',
                        snackbarStatus: (value) {
                      Get.find<UserAuth>().setRole(userRole.Buyer);

                      if (value == SnackbarStatus.CLOSED) {
                        Get.toNamed(Routes.HOME);
                      }
                    });
                    //print(Get.find<UserAuth>().getRole().toString());
                 */
                  },
                ),
                Text(
                  'لو لم يكن لديك حساب',
                  style: headline4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'يمكنك التسجيل',
                      style: headline4,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.SignupView);
                      },
                      child: Text(
                        'من هنا',
                        style: headline4.copyWith(color: KAccentColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthiocationHeader extends StatelessWidget {
  const AuthiocationHeader({
    @required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .4,
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: IconButton(
                iconSize: Get.width * .07,
                icon: Icon(
                  Icons.close,
                ),
                onPressed: () {
                  Get.back();
                }),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Center(
                  child: SizedBox(
                    width: Get.width * .3,
                    child: Image.asset('images/logodark.png'),
                  ),
                ),
              ),
              Container(
                child: Text(
                  title,
                  style: headline2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
