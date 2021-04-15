import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustomImageCached.dart';
import 'package:carpart/app/data/component/CustomIndicator.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/modules/order/bindings/order_binding.dart';
import 'package:carpart/app/modules/order/controllers/order_controller.dart';
import 'package:carpart/app/data/model/oder_detaile_model.dart';
import 'package:carpart/app/data/model/offer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderDetailesView extends GetView<OrderController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بيانات الطلب'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          FutureBuilder(
              future: controller.getOrderDetailes(Get.arguments[0]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return orderDetailes(snapshot.data);
                } else if (snapshot.hasError) {
                  return Center(
                      child: CustomIndicator(
                    indicatorStatus: IndicatorStatus.error,
                  ));
                }
                return Center(child: CustomIndicator());
              }),
        ],
      ),
    );
  }

  Widget orderDetailes(OderDetaileModel orderDetaileModel) {
    return Column(
      children: [
        orderCard(orderDetaileModel),
        KRole == userRole.Client
            ? offerClient(orderDetaileModel)
            : SizedBox.shrink(),
        KRole == userRole.Merchant
            ? offerMerchant(orderDetaileModel)
            : SizedBox.shrink(),
        KRole == userRole.DeliveryAgent
            ? offerDeliveryAgent()
            : SizedBox.shrink(),
      ],
    );
  }

  Widget offerClient(OderDetaileModel orderDetaileModel) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: Get.width,
      constraints: BoxConstraints(minHeight: 150),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
      ),
      child: orderDetaileModel.merchantOffers.length == 0
          ? Center(
              child: Text(
                'لا توجد عروض حتى الان من التاجر',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          : Center(
              child: Column(
                children: List.generate(orderDetaileModel.merchantOffers.length,
                    (index) {
                  MerchantOffer merchantOffer =
                      orderDetaileModel.merchantOffers.elementAt(index);

                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          'أسم التاجر',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(merchantOffer.userName),
                      ),
                      ListTile(
                        leading: Text(merchantOffer.name),
                        title: Text(merchantOffer.price.toString()),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.done_all_rounded,
                            color: KAccentColor,
                          ),
                          onPressed: () {
                            controller.acceptOffer(
                                offerId: orderDetaileModel.merchantOffers
                                    .elementAt(index)
                                    .id);
                          },
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
    );
  }

  Widget offerMerchant(OderDetaileModel orderDetaileModel) {
    // controller.getMerchantOffers(orderId: orderDetaileModel.id);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: Get.width,
      constraints: BoxConstraints(minHeight: 150),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'ادخل عرض السعر',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
                future:
                    controller.getMerchantOffers(orderId: orderDetaileModel.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<OfferModel> offerList = snapshot.data;
                    return Column(
                      children: List.generate(offerList.length, (index) {
                        return ListTile(
                          title:
                              Text(offerList.elementAt(index).name.toString()),
                          trailing:
                              Text(offerList.elementAt(index).price.toString()),
                        );
                      }),
                    );
                  } else if (snapshot.hasError) {
                    return CustomIndicator(
                      indicatorStatus: IndicatorStatus.error,
                    );
                  }
                  return CustomIndicator();
                }),
            CustemButton(
              title: 'ادخل عرض السعر',
              buttonController: controller.btnController,
              onPressed: () {
                controller.btnController.reset();
                Get.defaultDialog(
                  title: 'ادخل عرض السعر',
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'الماركة',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: controller.offerName,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'السعر',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: controller.offerPrice,
                        ),
                      ],
                    ),
                  ),
                  cancel: CustemButton(
                    title: 'ارسال',
                    buttonController: controller.btnController,
                    onPressed: () {
                      controller.addOffer(orderId: orderDetaileModel.id);
                      // Get.back();
                    },
                  ),
                  confirm: CustemButton(
                    title: 'الغاء',
                    buttonController: controller.btnController,
                    onPressed: () {
                      Get.back();
                      controller.btnController.reset();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget offerDeliveryAgent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: Get.width,
      constraints: BoxConstraints(minHeight: 150),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: Text('انت تبعد عن المتجر'),
            )
          ],
        ),
      ),
    );
  }

  Widget orderCard(OderDetaileModel orderDetaileModel) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageCached(
            imageUrl: "https://carpart.atpnet.net/Files/Order/" +
                orderDetaileModel.userId.toString() +
                "/" +
                orderDetaileModel.id.toString() +
                "/" +
                orderDetaileModel.image.toString(),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text('رقم الطلب'),
            trailing: Text(orderDetaileModel.id.toString()),
          ),
          ListTile(
            title: Text('حالة الطلب'),
            trailing: Text(
                OrderStatus.values[orderDetaileModel.status].toString().tr),
          ),
          ListTile(
            title: Text('تاريخ الطلب'),
            trailing: Text(DateFormat.MMMMd().format(orderDetaileModel.date)),
          ),
          ListTile(
            title: Text('ألماركة'),
            trailing: Text(orderDetaileModel.markName),
          ),
          ListTile(
            title: Text('الموديل'),
            trailing: Text(orderDetaileModel.modelName),
          ),
          ListTile(
            title: Text('رقم الهيكل'),
            trailing: Text(orderDetaileModel.vanNumber),
          ),
          ListTile(
            title: Text('وصف الطلب'),
            subtitle: Text(orderDetaileModel.description),
          ),
        ],
      ),
    );
  }
}
