import 'package:carpart/app/data/order_data.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carpart/app/modules/order/controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: List.generate(
          OrderList.length,
          (index) {
            return Card(
              child: ListTile(
                onTap: (){
                  Get.toNamed(Routes.OrderDetailesView);
                },
                isThreeLine: true,
                title: Text(OrderList.elementAt(index).OrderNumber),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(OrderList.elementAt(index).CarBrand),
                    Text(OrderList.elementAt(index).orderStatus.toString()),
                  ],
                ),
                trailing: Text(OrderList.elementAt(index).OrderDate),
                leading: Icon(
                  Icons.car_repair,
                  color: KAccentColor,
                ),
              ),
            );
          },
        ),
      ),
    ));
  }
}
