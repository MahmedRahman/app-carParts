import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
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
            title: Text('احمد عبد الرحمن'),
            subtitle: Text('Ahmed2020@gmail.com'),
            leading: Icon(Icons.ac_unit),
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
                        onTap: () {},
                        leading: Icon(Icons.wallet_giftcard),
                        title: Text('اجمالى عدد الطلبات'),
                        trailing: Text('23'),
                      ),
                      (Get.find<UserAuth>().getRole() != userRole.Buyer) ? ListTile(
                        onTap: () {},
                        leading: Icon(Icons.wallet_giftcard),
                        title: Text('اجمالى المبالغ المترتبة'),
                        trailing: Text('500 SR'),
                      ):SizedBox.fromSize(),
                       (Get.find<UserAuth>().getRole() != userRole.Buyer) ?ListTile(
                        onTap: () {},
                        leading: Icon(Icons.wallet_giftcard),
                        title: Text('اجمالى المبالغ المدفوعة'),
                        trailing: Text('2500  SR'),
                      ):SizedBox.fromSize(),
                       (Get.find<UserAuth>().getRole() != userRole.anonymous) ? ListTile(
                        onTap: () {},
                        leading: Icon(Icons.wallet_giftcard),
                        title: Text('طلبات التحويل'),
                        trailing: Text('32'),
                      ):SizedBox.fromSize(),
                      (Get.find<UserAuth>().getRole() != userRole.anonymous) ?ListTile(
                        onTap: () {
                          Get.toNamed(Routes.BANK);
                        },
                        leading: Icon(Icons.wallet_giftcard),
                        title: Text('حسابي البنكي'),
                      ):SizedBox.fromSize(),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.wallet_giftcard),
                        title: Text('مركز المساعدة'),
                        trailing: Text('01002002020'),
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
