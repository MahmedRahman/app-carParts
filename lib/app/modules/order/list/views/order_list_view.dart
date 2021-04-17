import 'package:carpart/app/data/component/CustomImageCached.dart';
import 'package:carpart/app/data/component/CustomIndicator.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/model/order_model.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/order_list_controller.dart';

class OrderListView extends GetView<OrderListController> {
  @override
  Widget build(BuildContext context) {
    OrderListController controller = Get.put(OrderListController());
    return Scaffold(
      body: FutureBuilder(
        future: controller.getOrder(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<OrderModel> orderModelList = snapshot.data;
            return orderModelList.length == 0
                ? Text('لا يوجد طلبات')
                : ListView(
                    children: List.generate(
                      orderModelList.length,
                      (index) {
                        return orderItem(
                          orderModel: orderModelList.elementAt(index),
                        );
                      },
                    ).toList(),
                  );
          } else if (snapshot.hasError) {
            return Center(
              child: CustomIndicator(
                indicatorStatus: IndicatorStatus.error,
              ),
            );
          }
          return Center(
            child: CustomIndicator(),
          );
        },
      ),
    );
  }

  Widget orderItem({@required OrderModel orderModel}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Get.toNamed(Routes.ORDER_DETAIL, arguments: [orderModel.id]);
              },
              isThreeLine: true,
              title: Text(orderModel.markName),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(orderModel.modelName +
                      " " +
                      orderModel.versionId.toString()),
                  Text(orderModel.vanNumber),
                ],
              ),
              trailing: Column(
                children: [
                  Text(DateFormat.MMMMd().format(orderModel.date)),
                  Text(OrderStatus.values[orderModel.status].toString().tr)
                ],
              ),
              leading: SizedBox(
                height: 50,
                width: 50,
                child: orderModel.image == null
                    ? Placeholder()
                    : CustomImageCached(
                        imageUrl: "https://carpart.atpnet.net/Files/Order/" +
                            orderModel.userId.toString() +
                            "/" +
                            orderModel.id.toString() +
                            "/" +
                            orderModel.image.toString(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
