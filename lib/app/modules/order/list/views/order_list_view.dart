import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustomImageCached.dart';
import 'package:carpart/app/data/component/CustomIndicator.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/model/order_model.dart';
import 'package:carpart/app/modules/home/views/home_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../controllers/order_list_controller.dart';

class OrderListView extends GetView<OrderListController> {
  @override
  Widget build(BuildContext context) {
    OrderListController controller = Get.put(OrderListController());
    controller.getOrder();
    return Scaffold(
      appBar: AppBar(
        title: Text('الطلبات'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: GetX<OrderListController>(
        builder: (builder) {
          return FutureBuilder(
            future: controller.orderModelList.value,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<OrderModel> orderModelList = snapshot.data;
                return orderModelList.length == 0
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset('images/noorder.json', width: Get.width),
                          Text('لا يوجد طلبات'),
                        ],
                      ))
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
          );
        },
      ),
    );
  }

  Widget orderItem({@required OrderModel orderModel}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            /*  decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                         borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
                        */
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.ORDER_DETAIL, arguments: [orderModel.id]);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: Get.width * .35,
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              orderModel.image == null
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    )
                                  : Expanded(
                                      child: Container(
                                        width: Get.width * .35,
                                        height: 130,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: CustomImageCached(
                                          imageUrl:
                                              "https://carpart.atpnet.net/Files/Order/" +
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
                      ),
                    ),
                    Container(
                      height: 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'رقم  الطلب' + ' : ' + orderModel.id.toString(),
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            orderModel.markName +
                                ' , ' +
                                orderModel.modelName +
                                ' , ' +
                                orderModel.versionId.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            DateFormat.yMMMd().format(orderModel.date),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            OrderStatus.values[orderModel.status].toString().tr,
                            style: TextStyle(
                              color: Colors.red.withOpacity(.5),
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            StringExtension.displayTimeAgoFromTimestamp(
                              orderModel.date.toString(),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          KRole == userRole.Client
                              ? OrderStatus.values[orderModel.status].index <=
                                      OrderStatus.Paid.index
                                  ? IconButton(icon: Icon(Icons.delete), onPressed: (){

                                            controller.deleteOrder(
                                            orderModel.id.toString());
                                  })
                                  
                                  
                                  /*ElevatedButton(
                                      onPressed: () {
                                        controller.deleteOrder(
                                            orderModel.id.toString());
                                      },
                                      //child: Text('حذف'),
                                    )*/
                                  : Container()
                              : Container()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(thickness: 1.5,)
        ],
      ),
    );
  }
}

extension StringExtension on String {
  static String displayTimeAgoFromTimestamp(String timestamp) {
    final year = int.parse(timestamp.substring(0, 4));
    final month = int.parse(timestamp.substring(5, 7));
    final day = int.parse(timestamp.substring(8, 10));
    final hour = int.parse(timestamp.substring(11, 13));
    final minute = int.parse(timestamp.substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    final int diffInHours = DateTime.now().difference(videoDate).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'دقيقية';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'ساعة';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'يوم';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'أسبوع';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'شهر';
    } else {
      timeValue = (diffInHours / (24 * 365)).floor();
      timeUnit = 'سنة';
    }

    timeAgo = timeValue.toString() + ' ' + timeUnit;
    timeAgo += timeValue > 1 ? '' : '';

    return 'منذ' + ' ' + timeAgo;
  }
}
