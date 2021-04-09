import 'package:carpart/app/data/component/CustomIndicator.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/modules/notifaction/model/notifaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carpart/app/modules/notifaction/controllers/notifaction_controller.dart';

class NotifactionView extends GetView<NotifactionController> {
    NotifactionController controller = Get.put(NotifactionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: FutureBuilder(
          future: controller.getNotifaction(),
          builder: (context, snapshot) {
            List<NotifactionModel> notifactionModel = snapshot.data;

            return Column(
              children: List.generate(
                notifactionModel.length,
                (index) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Card(
                          child: ListTile(
                            title: Text(notifactionModel.elementAt(index).name??''),
                            subtitle: Text(notifactionModel.elementAt(index).body??''),
                            leading: Icon(
                              Icons.notifications,
                              color: KAccentColor,
                            ),
                            trailing: Text('15 Oct'),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: CustomIndicator(),
                    );
                  }
                  return Center(
                    child: CustomIndicator(),
                  );
                },
              ),
            );
          }),
    ));
  }
}
