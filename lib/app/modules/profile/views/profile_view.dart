import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/component/CustomImageCached.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/modules/home/controllers/home_controller.dart';
import 'package:carpart/app/modules/home/views/home_view.dart';
import 'package:carpart/app/modules/profile/views/profile_profile_detailes_edit_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:carpart/app/modules/profile/controllers/profile_controller.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حسابى'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              await Get.to(
                ProfileDetailesEditView(),
                fullscreenDialog: true,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              KRole = userRole.anonymous;
              Get.find<UserAuth>().setUserToken(null);
              Kselectindex.value = 0;
              NotifactionCount.value = 0;
              Get.offAndToNamed(Routes.HOME);
            },
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Obx(() {
                  return Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(KUserImage.value),
                          ),
                          KRole == userRole.Client
                              ? Container()
                              : Positioned(
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
                                        style: TextStyle(color:  KRole == userRole.DeliveryAgent ?  Color(0xFFFFCC30) :  Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              KName.value,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              KEmail.value,
                              style: TextStyle(fontSize: 10),
                            ),
                            RatingBar.builder(
                              initialRating: double.parse(KRate.value.toString()) ,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                            itemSize:15 ,
                              itemBuilder: (context, _) => 
                              Icon(
                                Icons.star,
                                size: 10,
                                color: Colors.amber,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: KScandaryColor),
                  ],
                ),
                child: SizedBox(
                  width: Get.width,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Kselectindex.value = 1;
                        },
                        leading: Image.asset('images/cart-car.png'),
                        title: Text('الطلبات'),
                        trailing: Text(KOrderCount.value.toString()),
                      ),
                      Divider(),
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
                        onTap: () async {
                          await canLaunch('tel:+$helpPhoneNumber??' '')
                              ? await launch('tel:+$helpPhoneNumber??' '')
                              : throw 'Could not launch tel:+$helpPhoneNumber??'
                                  '';
                        },
                        leading: Image.asset('images/support.png'),
                        title: Text('مركز المساعدة'),
                        trailing: Text(helpPhoneNumber ?? ''),
                      ),
                      Divider(),
                      ListTile(
                        onTap: () {
                          Get.toNamed(Routes.ContactusView);
                        },
                        leading: Icon(Icons.call),
                        title: Text('اتصل بنا'),
                      ),
                      Divider(),
                      ListTile(
                        onTap: () {
                          Share.share('check out my website https://tsp.sa');
                        },
                        leading: Icon(Icons.share),
                        title: Text('شارك التطبيق'),
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              await canLaunch(Kwhatapp)
                                  ? await launch(Kwhatapp)
                                  : throw 'Could not launch $Kwhatapp';
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xff445969),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Image.asset('images/whatsapp.png'),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () async {
                              await canLaunch(KInstegram)
                                  ? await launch(KInstegram)
                                  : throw 'Could not launch $KInstegram';
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xff445969),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Image.asset('images/instagram.png'),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () async {
                              await canLaunch(KTwitter)
                                  ? await launch(KTwitter)
                                  : throw 'Could not launch $KTwitter';
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xff445969),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Image.asset('images/twitter.png'),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () async {
                              await canLaunch(KSnapChat)
                                  ? await launch(KSnapChat)
                                  : throw 'Could not launch $KSnapChat';
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xff445969),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Image.asset('images/snapchat.png'),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 100,
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
