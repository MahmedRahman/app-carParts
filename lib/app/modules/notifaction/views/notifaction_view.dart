import 'package:carpart/app/data/component/CustomIndicator.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/data/model/notifaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carpart/app/modules/notifaction/controllers/notifaction_controller.dart';

class NotifactionView extends GetView<NotifactionController> {
  @override
  Widget build(BuildContext context) {
    NotifactionController controller = Get.put(NotifactionController());
    return Scaffold(
        body: FutureBuilder(
      future: controller.getNotifaction(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<NotifactionModel> notifactionModel = snapshot.data;
          return notifactionModel.length == 0
              ? Center(child: Text('لا يوجد اشعارات'))
              : ListView(
                  children: List.generate(
                    notifactionModel.length,
                    (index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                              notifactionModel.elementAt(index).name ?? ''),
                          subtitle: Text(
                              notifactionModel.elementAt(index).body ?? ''),
                          leading: Icon(
                            Icons.notifications,
                            color: KAccentColor,
                          ),
                          trailing: Text('15 Oct'),
                        ),
                      );
                    },
                  ),
                );
        } else if (snapshot.hasError) {
          return Center(child: CustomIndicator());
        }

        return Center(child: CustomIndicator());
      },
    ));
  }
}
