import 'package:carpart/app/data/model/order_model.dart';
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
      child: FutureBuilder(
          future: controller.getOrder(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<OrderModel> orderModelList;
              orderModelList = snapshot.data;
              return Column(
                  children: List.generate(orderModelList.length, (index) {
                return orderItem(
                  orderModel: orderModelList.elementAt(index),
                );
              }).toList());
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    ));
  }

  Card orderItem({@required OrderModel orderModel}) {
    return Card(
      child: ListTile(
        onTap: () {
          Get.toNamed(Routes.OrderDetailesView);
        },
        isThreeLine: true,
        title: Text(orderModel.vanNumber),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(orderModel.vanNumber),
            Text(orderModel.vanNumber),
          ],
        ),
        trailing: Text(orderModel.vanNumber),
        leading: Icon(
          Icons.car_repair,
          color: KAccentColor,
        ),
      ),
    );
  }
}
