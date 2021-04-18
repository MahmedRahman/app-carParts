import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustomImageCached.dart';
import 'package:carpart/app/data/component/CustomIndicator.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/data/model/oder_detaile_model.dart';
import 'package:carpart/app/data/model/offer_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/order_detail_controller.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  @override
  Widget build(BuildContext context) {
    controller.OrderId = Get.arguments[0];
    controller.getOrderDetailes();

    if (KRole == userRole.Merchant) {
      controller.getMerchantOffers();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('بيانات الطلب'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          GetX<OrderDetailController>(builder: (builder) {
            return FutureBuilder(
                future: controller.oderModel.value,
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
                });
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
            ? Column(
                children: [
                  offerView(orderDetaileModel),
                  deliveryView(orderDetaileModel),
                  orderPayment(orderDetaileModel)
                ],
              )
            : SizedBox.shrink(),
        KRole == userRole.Merchant
            ? offerMerchant(orderDetaileModel)
            : SizedBox.shrink(),
        KRole == userRole.DeliveryAgent
            ? Column(
                children: [
                  offerView(orderDetaileModel),
                  offerDeliveryAgent(orderDetaileModel),
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }

  Widget offerView(OderDetaileModel orderDetaileModel) {
    return Container(
      child: orderDetaileModel.merchantOffers.length == 0
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: Get.width,
              constraints: BoxConstraints(minHeight: 150),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
              child: Center(
                child: Text(
                  'لا توجد عروض التاجر',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          : Center(
              child: Column(
                children: List.generate(orderDetaileModel.merchantOffers.length,
                    (index) {
                  Offer merchantOffer =
                      orderDetaileModel.merchantOffers.elementAt(index);
//(merchantOffer.status = 1)
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'أسم التاجر',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(merchantOffer.userName),
                        ),
                        ListTile(
                          title: Text(
                            'عنوان التاجر',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(merchantOffer.userName),
                        ),

                                   ListTile(
                          title: Text(
                            'حالة الطلب',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(RequestStatus.values[merchantOffer.status].toString().tr),
                        ),
                        Divider(),
                        ListTile(
                          title: Text(merchantOffer.name),
                          trailing: Text(merchantOffer.price.toString()),
                        ),
                        merchantOffer.status != 1
                            ? TextButton(
                                child: Text('قبول'),
                                onPressed: () {
                                  controller.acceptMerchantOffer(
                                    offerId: orderDetaileModel.merchantOffers
                                        .elementAt(index)
                                        .id,
                                  );
                                },
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  );
                }),
              ),
            ),
    );
  }

  Widget offerMerchant(OderDetaileModel orderDetaileModel) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: Get.width,
      constraints: BoxConstraints(minHeight: 150),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'عروض الاسعار',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                //TextButton(onPressed: () {}, child: Text('مفرد')),
                // TextButton(onPressed: () {}, child: Text('متعدد'))
              ],
            ),
            Divider(),
            GetX<OrderDetailController>(builder: (builder) {
              return FutureBuilder(
                  future: controller.MerchantOffersList.value,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<OfferModel> offerList = snapshot.data;
                      return offerList.length == 0
                          ? Text('لم يتم تقديم اى عروض')
                          : Column(
                              children:
                                  List.generate(offerList.length, (index) {
                                return ListTile(
                                  title: Text(offerList
                                      .elementAt(index)
                                      .name
                                      .toString()),
                                  trailing: Text(offerList
                                      .elementAt(index)
                                      .price
                                      .toString()),
                                );
                              }),
                            );
                    } else if (snapshot.hasError) {
                      return CustomIndicator(
                        indicatorStatus: IndicatorStatus.error,
                      );
                    }
                    return CustomIndicator();
                  });
            }),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'ادخل عرض السعر',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                TextButton(onPressed: () {}, child: Text('مفرد')),
                // TextButton(onPressed: () {}, child: Text('متعدد'))
              ],
            ),
            ListTile(
              title: Text('ماركة القطعة'),
              subtitle: SizedBox(
                  child: TextFormField(
                controller: controller.offerName,
              )),
            ),
            ListTile(
              title: Text('سعر'),
              subtitle: SizedBox(
                  child: TextFormField(
                keyboardType: TextInputType.number,
                controller: controller.offerPrice,
              )),
            ),
            Divider(),
            CustemButton(
              title: 'ارسال',
              buttonController: controller.btnController,
              onPressed: () {
                controller.addMerchantOffer();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget offerDeliveryAgent(OderDetaileModel orderDetaileModel) {
    var KMinPrice =
        (orderDetaileModel.distance * KMPriceMin.toInt()) + BaseDeliveryPrice;
    var KMaxPrice =
        (orderDetaileModel.distance * KMPriceMax.toInt()) + BaseDeliveryPrice;

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
              trailing: Text(
                  orderDetaileModel.distance.toStringAsFixed(2) + ' ' + 'كم'),
            ),
            ListTile(
              title: Text('المتجر يبعد عن العميل'),
              trailing: Text(
                  orderDetaileModel.distance.toStringAsFixed(2) + ' ' + 'كم'),
            ),
            ListTile(
              title: Text('تكلفة التوصيل'),
              trailing: Text('بين' +
                  ' ' +
                  KMinPrice.toStringAsFixed(2) +
                  'الى' +
                  ' ' +
                  KMaxPrice.toStringAsFixed(2) +
                  'ريال'),
            ),
            orderDetaileModel.deliveryOffers.length == 0
                ? Column(
                    children: [
                      Divider(),
                      ListTile(
                        title: Text(
                          'ادخل عرضك',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: TextFormField(
                          controller: controller.offerPrice,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      CustemButton(
                        title: 'ارسال',
                        buttonController: controller.btnController,
                        onPressed: () {
                          double offerPrice =
                              double.parse(controller.offerPrice.text);
                          if (offerPrice >= KMinPrice &&
                              offerPrice <= KMaxPrice) {
                            controller.addDeliveryOffer();
                          } else {
                            showSnackBar(
                                message: 'يجب ان يكون الرقم المضاف بين رقمين',
                                snackbarStatus: () {
                                  controller.restBtn();
                                });
                          }
                        },
                      )
                    ],
                  )
                : Column(
                    children: [
                      ListTile(
                        title: Text('عرض مقدم'),
                        trailing: Text(orderDetaileModel
                            .deliveryOffers.first.price
                            .toString()),
                      ),
                      ListTile(
                        title: Text('حالة'),
                        trailing: Text(RequestStatus.values[
                                orderDetaileModel.deliveryOffers.first.status]
                            .toString()
                            .tr),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget deliveryView(OderDetaileModel orderDetaileModel) {
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
          child: orderDetaileModel.deliveryOffers.length == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'لا يوجد عروض توصيل',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              : Column(
                  children: List.generate(
                      orderDetaileModel.deliveryOffers.length, (index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text('أسم المندوب'),
                          trailing: Text(orderDetaileModel.deliveryOffers
                              .elementAt(index)
                              .userName
                              .toString()),
                        ),
                        ListTile(
                          title: Text('قيمية العرض'),
                          trailing: Text(orderDetaileModel.deliveryOffers
                              .elementAt(index)
                              .price
                              .toString()),
                        ),
                        ListTile(
                          title: Text('حالة العرض'),
                          trailing: Text(RequestStatus.values[orderDetaileModel
                                  .deliveryOffers
                                  .elementAt(index)
                                  .status]
                              .toString()
                              .tr),
                        ),
                        orderDetaileModel.deliveryOffers
                                    .elementAt(index)
                                    .status ==
                                0
                            ? CustemButton(
                                title: 'قبول',
                                buttonController: controller.btnController,
                                onPressed: () {
                                  controller.acceptDeliveryOffer(
                                      offerId: orderDetaileModel.deliveryOffers
                                          .elementAt(index)
                                          .id);
                                },
                              )
                            : SizedBox.shrink(),
                      ],
                    );
                  }).toList(),
                )),
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
            title: Text('سنة الصنع'),
            trailing: Text(orderDetaileModel.versionId.toString()),
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

  Widget orderPayment(OderDetaileModel orderDetaileModel) {


    return orderDetaileModel.status >= 4 ? Container(
      
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text('قيمة العرض'),
            trailing:
                Text(orderDetaileModel.merchantOffers.first.price.toString()),
          ),
          ListTile(
            title: Text('قيمة عرض التوصيل'),
            trailing:
                Text(orderDetaileModel.deliveryOffers.first.price.toString()),
          ),
          ListTile(
            title: Text('رسوم إدارية'),
            trailing: Text(KAdministrativeFees.toString()),
          ),
          ListTile(
            title: Text('الإجمالي'),
            trailing: Text((orderDetaileModel.merchantOffers.first.price?? 0 +
        orderDetaileModel.deliveryOffers.first.price??0 + KAdministrativeFees).toString()),
          ),
          CustemButton(
            title: 'دفع',
            buttonController: controller.btnController,
            onPressed: () {
              controller.setPaid();
            },
          )
        ],
      ),
    ):SizedBox.shrink();
  }
}
