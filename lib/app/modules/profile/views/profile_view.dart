import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/component/CustomImageCached.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/modules/home/controllers/home_controller.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carpart/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: CustomImageCached(imageUrl: KUserImage,)
                      ),
                      Positioned(
                        bottom: 1,
                        left: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff445969),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 15,
                            ),
                            child: Text(
                              KRole.toString().tr,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          KName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(KEmail),
                      ],
                    ),
                  ),
                 Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
//                          Get.back();

                         // KRole = userRole.anonymous;

                          //Get.find<UserAuth>().setUserToken(null);

                        //  Get.offAndToNamed(Routes.HOME);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: KScandaryColor)]),
                child: SizedBox(
                  width: Get.width,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Get.find<HomeController>().selectindex.value = 1;
                        },
                        leading: Image.asset('images/cart-car.png'),
                        title: Text('الطلبات'),
                        //trailing: Text('23'),
                      ),
                      (KRole != userRole.Client)
                          ? ListTile(
                              onTap: () {},
                              leading: Image.asset('images/XMLID_1441_.png'),
                              title: Text('اجمالى المبالغ المترتبة'),
                              trailing: Text(KBalance.toString()),
                            )
                          : SizedBox.fromSize(),
                      (KRole != userRole.Client)
                          ? ListTile(
                              onTap: () {},
                              leading: Image.asset('images/XMLID_1441_.png'),
                              title: Text('اجمالى المبالغ المدفوعة'),
                              trailing: Text(KPaidBalance.toString()),
                            )
                          : SizedBox.fromSize(),
                      (KRole != userRole.Client)
                          ? ListTile(
                              onTap: () {
                                Get.toNamed(Routes.PAYMENT_LIST);
                              },
                              leading: Image.asset('images/transfer.png'),
                              title: Text('طلبات التحويل'),
                              //  trailing: Text('32'),
                            )
                          : SizedBox.fromSize(),
                      (KRole != userRole.Client)
                          ? ListTile(
                              onTap: () {
                                Get.toNamed(Routes.BANK_LIST);
                              },
                              leading: Image.asset('images/credit-card.png'),
                              title: Text('حسابي البنكي'),
                            )
                          : SizedBox.fromSize(),
                      ListTile(
                        onTap: () {},
                        leading: Image.asset('images/support.png'),
                        title: Text('مركز المساعدة'),
                        trailing: Text(helpPhoneNumber),
                      ),
                      ListTile(
                        onTap: () {
                          Get.toNamed(Routes.ContactusView);
                        },
                        leading: Icon(Icons.call),
                        title: Text('اتصل بنا'),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.share),
                        title: Text('شارك التطبيق'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xff445969),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Image.asset('images/whatsapp.png'),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xff445969),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Image.asset('images/instagram.png'),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xff445969),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Image.asset('images/twitter.png'),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xff445969),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Image.asset('images/snapchat.png'),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
