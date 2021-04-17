import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/data/model/oder_detaile_model.dart';
import 'package:carpart/app/data/model/offer_model.dart';
import 'package:carpart/app/data/webServices.dart';
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

  restBtn() {
    btnController.stop();
  }

  Future getOrderDetailes() async {
    return await WebServices().getOrderDetailes(OrderId).then((response) {
      final oderDetaileModel = oderDetaileModelFromJson(response.bodyString);
      oderModel.value = Future.value(oderDetaileModel);
      return oderDetaileModel;
    }, onError: (err) {
      return Future.error('error');
    });
  }

  addMerchantOffer() async {
    Response response = await WebServices().addOffer(
      orderId: OrderId,
      name: offerName.text,
      price: double.parse(offerPrice.text.toString()),
    );

    if (response.hasError) {
    } else {
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
    Response response = await WebServices().getMerchantOffers(OrderId);
    final offerModel = offerModelFromJson(response.bodyString);
    MerchantOffersList.value = Future.value(offerModel);
    return offerModel;
  }

  acceptMerchantOffer({@required int offerId}) async {
    Response response = await WebServices().acceptOffer(offerId);
    print(response.bodyString);
    if (response.body['IsSuccess']) {
      showSnackBar(
          message: 'تم اختيار العرض المقدم',
          snackbarStatus: () {
            getOrderDetailes();
          });
    }
    return response;
  }

  addDeliveryOffer() async {
    Response response = await WebServices().addDeliveryOffer(
      orderId: OrderId,
      price: double.parse(offerPrice.text.toString()),
    );
    if (response.hasError) {
    } else {
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


  acceptDeliveryOffer({@required int offerId}) async {
    Response response = await WebServices().acceptDeliveryOffer(offerId);
    print(response.bodyString);
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
