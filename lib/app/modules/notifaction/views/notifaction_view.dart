import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:carpart/app/modules/notifaction/controllers/notifaction_controller.dart';

class NotifactionView extends GetView<NotifactionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(80, (index) {
            return Column(
              children: [
                Card(
                  child: ListTile(
                    title: Text('العنوان الخاص بالاشعار '),
                    subtitle: Text('نص نص'),
                    leading: Icon(Icons.notifications,color: KAccentColor,),
                    trailing: Text('15 Oct'),
                  ),
                ),
             
              ],
            );
          }),
        ),
      )
    );
  }
}
  