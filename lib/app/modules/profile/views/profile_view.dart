import 'package:carpart/app/data/auth.dart';
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
        child: Column(
          children: [
          ListTile(
            title: Text(KName),
            subtitle: Text(KEmail),
            leading: Icon(Icons.account_circle),
          ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                decoration: BoxDecoration(

                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: KScandaryColor
                    )
                  ]
                ),
                child: SizedBox(
                  width: Get.width,
                 
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Get.find<HomeController>().selectindex.value = 1;
                        },
                        leading: Icon(Icons.wallet_giftcard),
                        title: Text('الطلبات'),
                        //trailing: Text('23'),
                      ),
                      (KRole != userRole.Client) ? ListTile(
                        onTap: () {},
                        leading: Icon(Icons.wallet_giftcard),
                        title: Text('اجمالى المبالغ المترتبة'),
                       // trailing: Text('500 SR'),
                      ):SizedBox.fromSize(),
                       (KRole != userRole.Client) ?ListTile(
                        onTap: () {},
                        leading: Icon(Icons.wallet_giftcard),
                        title: Text('اجمالى المبالغ المدفوعة'),
                       // trailing: Text('2500  SR'),
                      ):SizedBox.fromSize(),
                       (KRole != userRole.anonymous) ? ListTile(
                        onTap: () {
                          Get.toNamed(Routes.PAYMENT_LIST);
                        },
                        leading: Icon(Icons.wallet_giftcard),
                        title: Text('طلبات التحويل'),
                      //  trailing: Text('32'),
                      ):SizedBox.fromSize(),
                      (KRole != userRole.anonymous) ?ListTile(
                        onTap: () {
                          Get.toNamed(Routes.BANK_LIST);
                        },
                        leading: Icon(Icons.wallet_giftcard),
                        title: Text('حسابي البنكي'),
                      ):SizedBox.fromSize(),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.wallet_giftcard),
                        title: Text('مركز المساعدة'),
                        trailing: Text(helpPhoneNumber),
                      ),
                      ListTile(
                        onTap: () {
                          Get.toNamed(Routes.ContactusView);
                        },
                        leading: Icon(Icons.wallet_giftcard),
                        title: Text('اتصل بنا'),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.wallet_giftcard),
                        title: Text('شارك التطبيق'),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
