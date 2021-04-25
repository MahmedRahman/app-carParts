import 'package:carpart/app/api/response_model.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/data/model/googel_distance_model.dart';
import 'package:carpart/app/data/model/oder_detaile_model.dart';
import 'package:carpart/app/data/model/offer_model.dart';
import 'package:carpart/app/api/webServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class OrderDetailController extends GetxController {
  int OrderId;

  TextEditingController offerName = new TextEditingController();
  TextEditingController offerPrice = new TextEditingController();

  final RoundedLoadingButtonController btnController =
      new RoundedLoadingButtonController();

  final MerchantOffersList = Future.value().obs;
  final oderModel = Future.value().obs;
  var distance = ''.obs;
  var destinationAddresses = ''.obs;

  restBtn() {
    btnController.stop();
  }

  Future getOrderDetailes() async {
    ResponsModel responsModel = await WebServices().getOrderDetailes(OrderId);

    if (responsModel.success) {
      Response response = responsModel.data;

      final oderDetaileModel = oderDetaileModelFromJson(response.bodyString);
      oderModel.value = Future.value(oderDetaileModel);
      return oderDetaileModel;
    }
  }

  addMerchantOffer() async {
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
            restBtn();
            getMerchantOffers();
          },
        );
      } else {
        showSnackBar(
          message: 'خطاء فى اضافة البيانات',
          snackbarStatus: () {
            restBtn();
          },
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
            restBtn();
          },
        );
      } else {
        showSnackBar(
          message: 'خطاء فى اضافة البيانات',
          snackbarStatus: () {
            restBtn();
          },
        );
      }
    }
  }

  setPaid() async {
    ResponsModel responsModel = await WebServices().setPaid(orderId: OrderId);

    if (responsModel.success) {
      Response response = responsModel.data;
      if (response.body['IsSuccess']) {
        showSnackBar(
            message: 'تم الدفع',
            snackbarStatus: () {
              restBtn();
              getOrderDetailes();
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
              restBtn();
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

    if (responsModel.success) {}
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


    destinationAddresses.value = googelDistanceModel.destinationAddresses.toString();

      distance.value =
          googelDistanceModel.rows.first.elements.first.distance.text;
    }
  }
}
