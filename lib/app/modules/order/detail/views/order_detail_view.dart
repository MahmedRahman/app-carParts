import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustomImageCached.dart';
import 'package:carpart/app/data/component/CustomIndicator.dart';
import 'package:carpart/app/data/component/MapSample.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/data/model/oder_detaile_model.dart';
import 'package:carpart/app/data/model/offer_model.dart';
import 'package:carpart/app/modules/order/detail/views/pay_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/order_detail_controller.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  @override
  Widget build(BuildContext context) {
    controller.OrderId = Get.arguments[0];
    controller.getOrderDetailes();

    if (KRole == userRole.Merchant) {
      controller.getMerchantOffers();
    }

    if (KRole == userRole.DeliveryAgent) {
      Geolocator.getCurrentPosition().then((_latLng) {
        Klatitude = _latLng.latitude;
        Klongitude = _latLng.longitude;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('بيانات الطلب'),
        centerTitle: true,
      ),
      body: GetX<OrderDetailController>(
        builder: (builder) {
          return FutureBuilder(
            future: controller.oderModel.value,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    orderDetailes(snapshot.data),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                    child: CustomIndicator(
                  indicatorStatus: IndicatorStatus.error,
                ));
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomIndicator(),
                  ],
                ),
              );
            },
          );
        },
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
                  clientOfferMerchanView(orderDetaileModel),
                  orderAdress(orderDetaileModel),
                  deliveryView(orderDetaileModel),
                  orderPayment(orderDetaileModel),
                  orderPayment(orderDetaileModel),
                  orderComplete(orderDetaileModel),
                ],
              )
            : SizedBox.shrink(),
        KRole == userRole.Merchant
            ? Column(
                children: [
                  offerMerchant(orderDetaileModel),
                  ordertoDelivery(orderDetaileModel),
                ],
              )
            : SizedBox.shrink(),
        KRole == userRole.DeliveryAgent
            ? Column(
                children: [
                  clientOfferMerchanView(orderDetaileModel),
                  offerDeliveryAgent(orderDetaileModel),
                  ordertoClient(orderDetaileModel),
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }

  Widget clientOfferMerchanView(OderDetaileModel orderDetaileModel) {
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
                  MerchantOffer merchantOffer =
                      orderDetaileModel.merchantOffers.elementAt(index);

                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 2)
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            ListTile(
                              dense: true,
                              title: Text(
                                'أسم التاجر',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(merchantOffer.userName),
                            ),
                            Divider(),
                            ListTile(
                              dense: true,
                              title: Text(
                                'عنوان التاجر',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Obx(() {
                                return Text(
                                  controller.destinationAddresses.value,
                                  overflow: TextOverflow.ellipsis,
                                );
                              }),
                            ),
                            Divider(),
                            Column(
                                children: List.generate(
                                    merchantOffer.details.length, (index) {
                              DeliveryOffer detail =
                                  merchantOffer.details.elementAt(index);
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      detail.name.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('|'),
                                    Text(detail.price.toString()),
                                    RequestStatus.values[detail.status] ==
                                            RequestStatus.Accept
                                        ? SizedBox.shrink()
                                        : Text('|'),
                                    RequestStatus.values[detail.status] ==
                                            RequestStatus.Accept
                                        ? SizedBox.shrink()
                                        : TextButton(
                                            onPressed: () {
                                              controller.acceptMerchantOffer(
                                                offerId: detail.id,
                                              );
                                            },
                                            child: Text('قبول'))
                                  ],
                                ),
                              );
                            }).toList()),
                          ],
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
    var inputtype = 0.obs;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: Get.width,
      constraints: BoxConstraints(minHeight: 150),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            orderDetaileModel.merchantOffers.length == 0
                ? Obx(() {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'عرض السعر',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            Container(
                              decoration: BoxDecoration(),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    primary: inputtype.value == 0
                                        ? KAccentColor
                                        : Colors.white),
                                onPressed: () {
                                  inputtype.value = 0;
                                },
                                child: Text(
                                  'مفرد',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  primary: inputtype.value == 1
                                      ? KAccentColor
                                      : Colors.white, // background
                                ),
                                onPressed: () {
                                  inputtype.value = 1;
                                },
                                child: Text(
                                  'متعدد',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        inputtype.value == 1
                            ? GetX<OrderDetailController>(builder: (builder) {
                                return FutureBuilder(
                                    future: controller.MerchantOffersList.value,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<OfferModel> offerList =
                                            snapshot.data;
                                        return offerList.length == 0
                                            ? Text('لم يتم تقديم اى عروض')
                                            : Column(
                                                children: List.generate(
                                                    offerList.length, (index) {
                                                  return Card(
                                                    child: ListTile(
                                                      title: Text(offerList
                                                          .elementAt(index)
                                                          .name
                                                          .toString()),
                                                      trailing: Text(offerList
                                                          .elementAt(index)
                                                          .price
                                                          .toString()),
                                                    ),
                                                  );
                                                }),
                                              );
                                      } else if (snapshot.hasError) {
                                        return CustomIndicator(
                                          indicatorStatus:
                                              IndicatorStatus.error,
                                        );
                                      }
                                      return CustomIndicator();
                                    });
                              })
                            : Container(),
                        Divider(),
                        Column(
                          children: [
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
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustemButton(
                                      title: 'ارسال',
                                      onPressed: () {
                                        inputtype.value == 1
                                            ? controller.addMultiMerchantOffer()
                                            : controller.addMerchantOffer();
                                      },
                                    ),
                                  ),
                                ),
                                inputtype.value == 1
                                    ? Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CustemButton(
                                            backgroundColor: KScandaryColor,
                                            title: 'اضافة',
                                            onPressed: () {
                                              controller
                                                  .addMerchantMultiOffer();
                                            },
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ],
                        )
                      ],
                    );
                  })
                : Column(
                    children: [
                      Text(
                        'العروض المقدمة',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Column(
                        children: List.generate(
                            orderDetaileModel
                                .merchantOffers.first.details.length, (index) {
                          return Card(
                            child: ListTile(
                              title: Text(orderDetaileModel
                                  .merchantOffers.first.details
                                  .elementAt(index)
                                  .name
                                  .toString()),
                              trailing: Text(orderDetaileModel
                                  .merchantOffers.first.details
                                  .elementAt(index)
                                  .price
                                  .toString()),
                            ),
                          );
                        }),
                      )
                    ],
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
    controller.getdistance(
      orderDetaileModel.merchantOffers.first.lat,
      orderDetaileModel.merchantOffers.first.lng,
    );
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
              trailing: Obx(() {
                return Text(controller.distance.value);
              }),
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
                        onPressed: () {
                          double offerPrice =
                              double.parse(controller.offerPrice.text);
                          if (offerPrice >= KMinPrice &&
                              offerPrice <= KMaxPrice) {
                            controller.addDeliveryOffer();
                          } else {
                            showSnackBar(
                                message: 'يجب ان يكون الرقم المضاف بين رقمين',
                                snackbarStatus: () {});
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
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderDetaileModel.markName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'رقم الطلب' + ' : ' + orderDetaileModel.id.toString(),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(orderDetaileModel.modelName),
                Text('تاريخ الطلب' +
                    ' : ' +
                    DateFormat.MMMMd()
                        .format(orderDetaileModel.date)
                        .toString()),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('موديل' + ' : ' + orderDetaileModel.versionId.toString()),
            SizedBox(
              height: 10,
            ),
            Text(
              'رقم الهيكيل' + ' : ' + orderDetaileModel.vanNumber.toString(),
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'وصف الطلب',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(orderDetaileModel.description),
            SizedBox(
              height: 10,
            ),

            Divider(),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: Get.width * .9,
              child: ElevatedButton(
                onPressed: () {
                  _launchURL(
                      'https://www.google.com/maps/search/?api=1&query=${orderDetaileModel.lat.toString()},${orderDetaileModel.lng.toString()}');
                },
                child: Text('عنوان الطلب'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            orderDetaileModel.merchantOffers.length == 0
                ? Container()
                : SizedBox(
                    width: Get.width * .9,
                    child: ElevatedButton(
                      onPressed: () {
                        _launchURL(
                            'https://www.google.com/maps/search/?api=1&query=${orderDetaileModel.merchantOffers.first.lat.toString()},${orderDetaileModel.merchantOffers.first.lng.toString()}');
                      },
                      child: Text('عنوان التاجر'),
                    ),
                  ),
            // Text('https://www.google.com/maps/search/?api=1&query=${orderDetaileModel.lat.toString()},${orderDetaileModel.lng.toString()}'),
          ],
        ),
      ),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  Widget orderPayment(OderDetaileModel orderDetaileModel) {
    /*
    var KToal = orderDetaileModel.merchantOffers.first.details.first.price ??
        0 + orderDetaileModel.deliveryOffers.first.price ??
        0 + KAdministrativeFees;
*/
    return orderDetaileModel.status >= 4
        ? Container(
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
                  trailing: Text(
                    orderDetaileModel.merchantOffers.first.details.first.price
                        .toString(),
                  ),
                ),
                ListTile(
                  title: Text('قيمة عرض التوصيل'),
                  trailing: Text(
                    orderDetaileModel.deliveryOffers.first.price.toString(),
                  ),
                ),
                ListTile(
                  title: Text('رسوم إدارية'),
                  trailing: Text(KAdministrativeFees.toString()),
                ),
                ListTile(
                  title: Text('الإجمالي'),
                  trailing: Text((orderDetaileModel
                              .merchantOffers.first.details.first.price +
                          orderDetaileModel.deliveryOffers.first.price +
                          KAdministrativeFees)
                      .toString()),
                ),
                OrderStatus.values[orderDetaileModel.status] ==
                        OrderStatus.DeliveryAgentOfferComplete
                    ? CustemButton(
                        title: 'دفع',
                        onPressed: () {
                          Get.to(PayView(), fullscreenDialog: true);
                        },
                      )
                    : Container()
              ],
            ),
          )
        : SizedBox.shrink();
  }

  Widget orderAdress(OderDetaileModel orderDetaileModel) {
    return OrderStatus.values[orderDetaileModel.status] ==
            OrderStatus.MerchantOfferComplete
        ? Column(
            children: [
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: Get.width * .9,
                child: ElevatedButton(
                  onPressed: () {
                    Geolocator.getCurrentPosition().then(
                      (_latLng) {
                        Klatitude = _latLng.latitude;
                        Klongitude = _latLng.longitude;
                        controller.setLocation();
                      },
                    );
                  },
                  child: Text('التوصيل لعنواني'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width * .9,
                child: ElevatedButton(
                  onPressed: () async {
                    await Get.to(MapScreen(), arguments: orderDetaileModel.id);
                    controller.setLocation();
                  },
                  child: Text('التوصيل لعنوان مختلف'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff445969),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          )
        : SizedBox.shrink();
  }

  Widget ordertoDelivery(OderDetaileModel orderDetaileModel) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        color: Colors.red,
        width: Get.width * .8,
        height: 60,
        child: SizedBox(
          width: Get.width * .9,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('تم التسليم الى المندوب'),
          ),
        ),
      ),
    );
  }

  Widget ordertoClient(OderDetaileModel orderDetaileModel) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        color: Colors.black,
        width: Get.width * .8,
        height: 60,
        child: SizedBox(
          width: Get.width * .9,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('تم التسليم الى العميل'),
          ),
        ),
      ),
    );
  }

  Widget orderComplete(OderDetaileModel orderDetaileModel) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        color: Colors.yellow,
        width: Get.width * .8,
        height: 60,
        child: SizedBox(
          width: Get.width * .9,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('تم الاستلام من المندوب'),
          ),
        ),
      ),
    );
  }
}
