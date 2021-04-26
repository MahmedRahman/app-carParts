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

    if (GetUtils.isNullOrBlank(Get.arguments)) {
      controller.phoneNumber.text = '';
      controller.password.text = '';
    } else {
      controller.phoneNumber.text = Get.arguments[0];
      controller.password.text = Get.arguments[1];
    }

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
                                  keyboardType: TextInputType.number,
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
                            obscureText: true,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
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
                      ),
                    ],
                  ),
                ),
                CustemButton(
                  title: 'تسجيل دخول',
                  buttonController: controller.btnController,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      controller.siginWithPhoneNumber();
                    } else {
                      controller.btnController.reset();
                    }
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'لو لم يكن لديك حساب',
                  style: headline4,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'يمكنك التسجيل',
                      style: headline4,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Get.offNamed(Routes.AUTHIOCATION_SIGNUP);
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
                Get.offNamed(Routes.HOME);
              },
            ),
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
