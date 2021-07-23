import 'package:carpart/app/api/response_model.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/data/model/googel_distance_model.dart';
import 'package:carpart/app/data/model/oder_detaile_model.dart';
import 'package:carpart/app/data/model/offer_model.dart';
import 'package:carpart/app/api/webServices.dart';
import 'package:carpart/app/modules/order/detail/views/pay_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  int OrderId;

  TextEditingController offerName = new TextEditingController();
  TextEditingController offerPrice = new TextEditingController();

  final MerchantOffersList = Future.value().obs;
  final oderModel = Future.value().obs;
  var distance = ''.obs;
  var destinationAddresses = ''.obs;

  Future getOrderDetailes() async {
    ResponsModel responsModel = await WebServices().getOrderDetailes(OrderId);

    if (responsModel.success) {
      Response response = responsModel.data;

      final oderDetaileModel = oderDetaileModelFromJson(response.bodyString);
      oderModel.value = Future.value(oderDetaileModel);
      return oderDetaileModel;
    }
  }

  Future addPaymentCard({
    @required String Brand,
    @required String CardNumber,
    @required String CardHolder,
    @required String ExpiryMonth,
    @required String ExpiryYear,
    @required String CVV,
  }) async {
    ResponsModel responsModel = await WebServices().addPaymentCard(
      Brand,
      CardNumber,
      CardHolder,
      ExpiryMonth,
      ExpiryYear,
      CVV,
      OrderId,
    );

    if (responsModel.success) {
      Response response = responsModel.data;

      if (response.body['IsSuccess']) {
        showSnackBar(
          message: 'تم الدفع بنجاح',
          snackbarStatus: () {
             Get.offAllNamed(Routes.HOME);
            //setPaid();
          },
        );
      } else {
        print(response.body['Message']);
        showSnackBar(
          message: 'خطاء فى  البيانات',
          snackbarStatus: () {},
        );
      }
    }
  }

  List<OfferModel> offerMultiList = new List<OfferModel>();
  addMerchantMultiOffer() async {
    if (GetUtils.isNullOrBlank(offerPrice.text) ||
        GetUtils.isNullOrBlank(offerName.text)) {
      showSnackBar(message: 'برجاء تحديد سعر للقطعة', snackbarStatus: () {});
    } else {
      offerMultiList.add(
        OfferModel(
          orderId: OrderId,
          name: offerName.text,
          price: double.parse(offerPrice.text.toString()),
        ),
      );
    }
    offerName.clear();
    offerPrice.clear();
    MerchantOffersList.value = Future.value(offerMultiList);
  }

  addMerchantOffer() async {
    if (GetUtils.isNullOrBlank(offerPrice.text) ||
        GetUtils.isNullOrBlank(offerName.text)) {
      showSnackBar(message: 'برجاء تحديد سعر للقطعة', snackbarStatus: () {});
    } else {
      ResponsModel responsModel = await WebServices().addOffer(
        orderId: OrderId,
        name: offerName.text,
        price: double.parse(offerPrice.text.toString()),
      );

      if (responsModel.success) {
        Response response = responsModel.data;

        if (response.body['IsSuccess']) {
          showSnackBar(
            message: 'تم الاضافة بنجاح',
            snackbarStatus: () {
              getOrderDetailes();
              getMerchantOffers();
            },
          );
        } else {
          showSnackBar(
            message: 'خطاء فى اضافة البيانات',
            snackbarStatus: () {},
          );
        }
      }
    }
  }

  addMultiMerchantOffer() async {
    ResponsModel responsModel =
        await WebServices().addMultiOffer(offerMultiList);
    if (responsModel.success) {
      Response response = responsModel.data;

      if (response.body['IsSuccess']) {
        showSnackBar(
          message: 'تم الاضافة بنجاح',
          snackbarStatus: () {
            getOrderDetailes();
            getMerchantOffers();
          },
        );
      } else {
        showSnackBar(
          message: 'خطاء فى اضافة البيانات',
          snackbarStatus: () {},
        );
      }
    }
  }

  Future getMerchantOffers() async {
    ResponsModel responsModel = await WebServices().getMerchantOffers(OrderId);
    if (responsModel.success) {
      Response response = responsModel.data;
      final offerModel = offerModelFromJson(response.bodyString);
      MerchantOffersList.value = Future.value(offerModel);
      return offerModel;
    }
  }

  acceptMerchantOffer({@required int offerId}) async {
    ResponsModel responsModel = await WebServices().acceptOffer(offerId);
    if (responsModel.success) {
      Response response = responsModel.data;

      if (response.body['IsSuccess']) {
        showSnackBar(
            message: 'تم اختيار العرض المقدم',
            snackbarStatus: () {
              getOrderDetailes();
            });
      }
      return response;
    }
  }

  addDeliveryOffer() async {
    ResponsModel responsModel = await WebServices().addDeliveryOffer(
      orderId: OrderId,
      price: double.parse(offerPrice.text.toString()),
    );

    if (responsModel.success) {
      Response response = responsModel.data;
      if (response.body['IsSuccess']) {
        showSnackBar(
          message: 'تم الاضافة بنجاح',
          snackbarStatus: () {
            getOrderDetailes();
          },
        );
      } else {
        showSnackBar(
          message: 'خطاء فى اضافة البيانات',
          snackbarStatus: () {},
        );
      }
    }
  }

  Future setPaid() async {
    ResponsModel responsModel = await WebServices().setPaid(orderId: OrderId);

    if (responsModel.success) {
      Response response = responsModel.data;
      if (response.body['IsSuccess']) {
        showSnackBar(
            message: 'تم الدفع',
            snackbarStatus: () {
              // getOrderDetailes();

              Get.offAllNamed(Routes.HOME);
            });
      }
    }
  }

  acceptDeliveryOffer({@required int offerId}) async {
    ResponsModel responsModel =
        await WebServices().acceptDeliveryOffer(offerId);
    if (responsModel.success) {
      Response response = responsModel.data;
      if (response.body['IsSuccess']) {
        showSnackBar(
            message: 'تم اختيار العرض المقدم',
            snackbarStatus: () {
              getOrderDetailes();
            });
      }
      return response;
    }
  }

  setLocation() async {
    ResponsModel responsModel = await WebServices().setLocation(
      orderid: OrderId,
      lat: Klatitude,
      lng: Klongitude,
    );

    if (responsModel.success) {
      getOrderDetailes();
    }
  }

  getdistance(double lat, double lang) async {
    ResponsModel responsModel = await WebServices().getdistance(
      originslat: Klatitude,
      originslang: Klongitude,
      destinationslat: 30.3827948,
      destinationslang: 31.0007844,
    );

    if (responsModel.success) {
      Response response = responsModel.data;
      final googelDistanceModel =
          googelDistanceModelFromJson(response.bodyString);

      destinationAddresses.value =
          googelDistanceModel.destinationAddresses.toString();

      distance.value =
          googelDistanceModel.rows.first.elements.first.distance.text;
    }
  }
}
