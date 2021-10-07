import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustomImageCached.dart';
import 'package:carpart/app/data/component/CustomIndicator.dart';
import 'package:carpart/app/data/component/MapSample.dart';
import 'package:carpart/app/data/component/custemImgePicker/CustemImagePicker.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/data/model/oder_detaile_model.dart';
import 'package:carpart/app/data/model/offer_model.dart';
import 'package:carpart/app/modules/order/detail/views/pay_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
        title: Text('طلب رقم : ${Get.arguments[0]}'),
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
                  phoneView(orderDetaileModel),
                  clientOfferMerchanView(orderDetaileModel),
                  orderAdress(orderDetaileModel),
                  deliveryView(orderDetaileModel),
                  orderPayment(orderDetaileModel),
                  orderComplete(orderDetaileModel),
                  orderRate(orderDetaileModel)
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
                  orderAdressLink(orderDetaileModel),
                  clientOfferMerchanView(orderDetaileModel),
                  offerDeliveryAgent(orderDetaileModel),
                  ordertoClient(orderDetaileModel),
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }

  Widget phoneView(OderDetaileModel orderDetaileModel) {
    return OrderStatus.values[orderDetaileModel.status].index >=
            OrderStatus.Paid.index
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            width: Get.width,
            constraints: BoxConstraints(minHeight: 150),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'رقم تليفون التاجر',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing:
                            Text(orderDetaileModel.merchantPhone.toString()),
                      ),
                      ListTile(
                        title: Text(
                          'رقم تليفون المندوب',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing:
                            Text(orderDetaileModel.deliveryPhone.toString()),
                      ),
                    ],
                  ),
                )),
          )
        : Container();
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
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
              ),
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
                                'حالة الطلب',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(
                                OrderStatus.values[orderDetaileModel.status]
                                    .toString()
                                    .tr,
                              ),
                            ),
                            ListTile(
                              dense: true,
                              title: Text(
                                'أسم التاجر',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(merchantOffer.userName),
                            ),
                            ListTile(
                              dense: true,
                              title: Text(
                                'عنوان التاجر',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(
                                merchantOffer.userAddress.toString(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            /* Column(
                                children: List.generate(
                                    merchantOffer.details.length, (index) {
                              DeliveryOffer detail =
                                  merchantOffer.details.elementAt(index);
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
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

*/
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                          children: List.generate(merchantOffer.details.length,
                              (index) {
                        DeliveryOffer detail =
                            merchantOffer.details.elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: KScandaryColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(color: Colors.grey, blurRadius: 2)
                              ],
                            ),
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  detail.name.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '|',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' S R ${detail.price.toString()}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                RequestStatus.values[detail.status] ==
                                        RequestStatus.Accept
                                    ? SizedBox.shrink()
                                    : TextButton(
                                        onPressed: () {
                                          controller.acceptMerchantOffer(
                                            offerId: detail.id,
                                          );
                                        },
                                        child: Text(
                                          'قبول',
                                          style: TextStyle(color: Colors.white),
                                        ))
                              ],
                            ),
                          ),
                        );
                      }).toList()),
                      SizedBox(
                        height: 10,
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

    return Column(
      children: [
        CustemImagePicker(
          showimagepath: KMerchantOfferImage.value,
          onclick: (value) {
            controller.imagelogo = value;
            //profileController.imagelogo = value;
          },
        ),
        //Text('data'),
        Container(
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
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  decoration: BoxDecoration(),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                        borderRadius: BorderRadius.circular(20),
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
                                ? GetX<OrderDetailController>(
                                    builder: (builder) {
                                    return FutureBuilder(
                                        future:
                                            controller.MerchantOffersList.value,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            List<OfferModel> offerList =
                                                snapshot.data;
                                            return offerList.length == 0
                                                ? Text('لم يتم تقديم اى عروض')
                                                : Column(
                                                    children: List.generate(
                                                        offerList.length,
                                                        (index) {
                                                      return Card(
                                                        child: ListTile(
                                                          title: Text(offerList
                                                              .elementAt(index)
                                                              .name
                                                              .toString()),
                                                          trailing: Text(
                                                              offerList
                                                                  .elementAt(
                                                                      index)
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
                                Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey, blurRadius: 2)
                                      ]),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 190,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              hintText: 'الماركة'
                                            ),
                                            controller: controller.offerName,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('|'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 80,
                                          child: TextFormField(
                                                decoration: InputDecoration(
                                              hintText: 'سعر'
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller: controller.offerPrice,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                                ? controller
                                                    .addMultiMerchantOffer()
                                                : controller.addMerchantOffer();
                                          },
                                        ),
                                      ),
                                    ),
                                    inputtype.value == 1
                                        ? Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                orderDetaileModel.merchantOffers.first.details
                                    .length, (index) {
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
        ),
      ],
    );
  }

  Widget offerDeliveryAgent(OderDetaileModel orderDetaileModel) {
    var Kmval = 0.0.obs;

    controller
        .getdistance(
      orderDetaileModel.merchantOffers.first.lat,
      orderDetaileModel.merchantOffers.first.lng,
    )
        .then((value) {
      print(value);

      Kmval.value = value / 1000 + orderDetaileModel.distance;
    });

    var KMinPrice = Kmval * KMPriceMin.toDouble() + BaseDeliveryPrice;
    var KMaxPrice = Kmval * KMPriceMax.toDouble() + BaseDeliveryPrice;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: Get.width,
      constraints: BoxConstraints(minHeight: 150),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            orderDetaileModel.deliveryOffers.length == 0
                ? Column(
                    children: [
                      ListTile(
                        title: Text('انت تبعد عن المتجر'),
                        trailing: Obx(() {
                          return Text(
                              '${(double.parse(controller.distance.value) / 1000).toString()} كم');
                        }),
                      ),
                      ListTile(
                        title: Text('المتجر يبعد عن العميل'),
                        trailing: Text(
                            orderDetaileModel.distance.toStringAsFixed(2) +
                                ' ' +
                                'كم'),
                      ),
                      Obx(() {
                        KMinPrice =
                            Kmval * KMPriceMin.toDouble() + BaseDeliveryPrice;
                        KMaxPrice =
                            Kmval * KMPriceMax.toDouble() + BaseDeliveryPrice;

                        return ListTile(
                          title: Text('تكلفة التوصيل'),
                          trailing: Text('بين' +
                              ' ' +
                              (Kmval * KMPriceMin.toDouble() +
                                      BaseDeliveryPrice)
                                  .toStringAsFixed(2) +
                              'الى' +
                              ' ' +
                              (Kmval * KMPriceMax.toDouble() +
                                      BaseDeliveryPrice)
                                  .toStringAsFixed(2) +
                              'ريال'),
                        );
                      }),
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
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
            )
          ]),
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
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomImageCached(
            imageUrl: "https://carpart.atpnet.net/Files/Order/" +
                orderDetaileModel.userId.toString() +
                "/" +
                orderDetaileModel.id.toString() +
                "/" +
                orderDetaileModel.image.toString(),
          ),
        ),
        Container(
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
                SizedBox(
                  height: 10,
                ),
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
                  'رقم الهيكيل' +
                      ' : ' +
                      orderDetaileModel.vanNumber.toString(),
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

                // Text('https://www.google.com/maps/search/?api=1&query=${orderDetaileModel.lat.toString()},${orderDetaileModel.lng.toString()}'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget orderAdressLink(OderDetaileModel orderDetaileModel) {
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
      child: Column(
        children: [
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
        ],
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
    return orderDetaileModel.status >= 5
        ? Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            width: Get.width,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
            child: Column(
              children: [
                Text('جميع الاسعار تشمل ضريبة القيمة المضافة'),
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
                  title: Text('ضريبة'),
                  trailing: Text(
                      ((orderDetaileModel.deliveryOffers.first.price +
                                  KAdministrativeFees) *
                              Ktax)
                          .toString()),
                ),
                ListTile(
                  title: Text('الإجمالي'),
                  trailing: Text((orderDetaileModel
                              .merchantOffers.first.details.first.price +
                          orderDetaileModel.deliveryOffers.first.price +
                          KAdministrativeFees +
                          ((orderDetaileModel.merchantOffers.first.details.first
                                      .price +
                                  orderDetaileModel.deliveryOffers.first.price +
                                  KAdministrativeFees) *
                              Ktax))
                      .toString()),
                ),
                OrderStatus.values[orderDetaileModel.status] ==
                        OrderStatus.DeliveryAgentOfferComplete
                    ? CustemButton(
                        title: 'الغاء الطلب',
                        onPressed: () {
                          controller
                              .deleteOrder(orderDetaileModel.id.toString())
                              .then((value) {
                            Get.toNamed(Routes.HOME);
                          });
                        },
                      )
                    : Container(),
                OrderStatus.values[orderDetaileModel.status] ==
                        OrderStatus.DeliveryAgentOfferComplete
                    ? CustemButton(
                        title: 'دفع',
                        onPressed: () {
                          Get.to(PayView(), fullscreenDialog: true);
                        },
                      )
                    : CustemButton(
                        title: 'تحميل الفاتورة',
                        onPressed: () async {
                          var _url =
                              "https://carpart.atpnet.net/Files/Invoices/${orderDetaileModel.id}.pdf";
                          await canLaunch(_url)
                              ? await launch(_url)
                              : throw 'Could not launch $_url';
                        },
                      ),
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
    return OrderStatus.values[orderDetaileModel.status] == OrderStatus.Paid
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              // color: Colors.red,
              width: Get.width * .8,
              height: 60,
              child: SizedBox(
                width: Get.width * .9,
                child: ElevatedButton(
                  onPressed: () {
                    controller.setOrderStatus(OrderStatus.MerchantGivePart);
                  },
                  child: Text('تم التسليم الى المندوب'),
                ),
              ),
            ),
          )
        : Container();
  }

  Widget ordertoClient(OderDetaileModel orderDetaileModel) {
    return Column(
      children: [
        OrderStatus.values[orderDetaileModel.status] ==
                OrderStatus.MerchantGivePart
            ? Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  //color: Colors.black,
                  width: Get.width * .8,
                  height: 60,
                  child: SizedBox(
                    width: Get.width * .9,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.setOrderStatus(OrderStatus.DeliveryGetPart);
                      },
                      child: Text('تم الاستلام من التاجر'),
                    ),
                  ),
                ),
              )
            : Container(),
        OrderStatus.values[orderDetaileModel.status] ==
                OrderStatus.DeliveryGetPart
            ? Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  //color: Colors.black,
                  width: Get.width * .8,
                  height: 60,
                  child: SizedBox(
                    width: Get.width * .9,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.setOrderStatus(OrderStatus.DeliveryGivePart);
                      },
                      child: Text('تم التسليم الى العميل'),
                    ),
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  Widget orderComplete(OderDetaileModel orderDetaileModel) {
    return OrderStatus.values[orderDetaileModel.status] ==
            OrderStatus.DeliveryGivePart
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              // color: Colors.yellow,
              width: Get.width * .8,
              height: 60,
              child: SizedBox(
                width: Get.width * .9,
                child: ElevatedButton(
                  onPressed: () {
                    controller.setOrderStatus(OrderStatus.Complete);
                  },
                  child: Text('تم الاستلام من المندوب'),
                ),
              ),
            ),
          )
        : Container();
  }

  Widget orderRate(OderDetaileModel orderDetaileModel) {
    double merchantRate = 0;
    double deliveryRate = 0;

    print(orderDetaileModel.merchantRate);
    print(orderDetaileModel.status.toString());
    return (OrderStatus.values[orderDetaileModel.status] ==
                OrderStatus.Complete &&
            orderDetaileModel.merchantRate == 0)
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: Get.width,
              child: ElevatedButton(
                onPressed: () {
                  Get.defaultDialog(
                      title: 'التقيم',
                      content: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          // color: Colors.yellow,
                          width: Get.width * .95,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 2)
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text('قيم التاجر'),
                              SizedBox(
                                height: 10,
                              ),
                              RatingBar(
                                initialRating: 0,
                                itemCount: 5,
                                itemSize: 50.0,
                                direction: Axis.horizontal,
                                onRatingUpdate: (double value) {
                                  merchantRate = value;
                                },
                                ratingWidget: RatingWidget(
                                  full: Icon(Icons.star),
                                  empty: Icon(Icons.star_border),
                                  half: Icon(Icons.star_border),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('قيم المندوب'),
                              SizedBox(
                                height: 10,
                              ),
                              RatingBar(
                                initialRating: 0,
                                itemCount: 5,
                                itemSize: 50.0,
                                direction: Axis.horizontal,
                                onRatingUpdate: (double value) {
                                  deliveryRate = value;
                                },
                                ratingWidget: RatingWidget(
                                  full: Icon(Icons.star),
                                  empty: Icon(Icons.star_border),
                                  half: Icon(Icons.star_border),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: Get.width,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.setRate(
                                          merchantRate:
                                              merchantRate.toInt().toString(),
                                          deliveryRate:
                                              deliveryRate.toInt().toString());
                                    },
                                    child: Text('تقيم الطلب'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ));
                },
                child: Text('قيم الان'),
              ),
            ),
          )
        : Container();
  }
}
