import 'package:carpart/app/data/component/CustomIndicator.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/data/model/notifaction_model.dart';
import 'package:carpart/app/modules/home/views/home_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carpart/app/modules/notifaction/controllers/notifaction_controller.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class NotifactionView extends GetView<NotifactionController> {
  @override
  Widget build(BuildContext context) {
    NotifactionController controller = Get.put(NotifactionController());
    controller.getNotifaction();



    return Scaffold(
      
      appBar: AppBar(
        title: Text('التنبيهات'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: GetX<NotifactionController>(builder: (builder) {
      return FutureBuilder(
        future: controller.notifactionList.value,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<NotifactionModel> notifactionModel = snapshot.data;
            return notifactionModel.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'images/nonotifaction.json',
                          width: Get.width,
                        ),
                        Text('لا يوجد اشعارات'),
                      ],
                    ),
                  )
                : ListView(
                    children: List.generate(
                      notifactionModel.length,
                      (index) {
                        return Card(
                          color: notifactionModel.elementAt(index).isRead
                              ? Colors.white
                              : Colors.grey,
                          child: ListTile(
                              onTap: () {
                                controller.setNotifactionRead(notifactionModel
                                    .elementAt(index)
                                    .id
                                    .toString());
                                //SetRead
                                Get.toNamed(
                                  Routes.ORDER_DETAIL,
                                  arguments: [
                                    notifactionModel.elementAt(index).refId
                                  ],
                                );
                              },
                              title: Text(
                                  notifactionModel.elementAt(index).name ?? ''),
                              subtitle: Text(
                                  notifactionModel.elementAt(index).body ?? ''),
                              leading: Icon(
                                Icons.notifications,
                                color: KAccentColor,
                              ),
                              trailing: Text(DateFormat.MMMMd().format(
                                  notifactionModel.elementAt(index).date))),
                        );
                      },
                    ),
                  );
          } else if (snapshot.hasError) {
            return Center(child: CustomIndicator());
          }

          return Center(child: CustomIndicator());
        },
      );
    }));
  }
}
