import 'dart:async';
import 'dart:io';

import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppUtils.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/data/model/order_model.dart';
import 'package:carpart/app/modules/home/controllers/home_controller.dart';
import 'package:carpart/app/modules/order/bindings/order_binding.dart';
import 'package:carpart/app/modules/order/model/oder_detaile_model.dart';
import 'package:carpart/app/modules/order/model/offer_model.dart';
import 'package:carpart/app/modules/order/providers/order_provider_provider.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class OrderController extends GetxController {
  //TODO: Implement OrderController
  TextEditingController vanNumber = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController versionYear = new TextEditingController();
  TextEditingController offerName = new TextEditingController();
  TextEditingController offerPrice = new TextEditingController();
  var markid = 0.obs;
  var modelId = 0.obs;

  String imageBytes;
  final RoundedLoadingButtonController btnController =
      new RoundedLoadingButtonController();

  createorder() async {
    Response response = await OrderProvider().createorder(
        markid: markid.value,
        modelId: modelId.value,
        versionId: versionYear.text,
        vanNumber: vanNumber.text,
        description: description.text,
        imageBytes: imageBytes);

    if (response.body['IsSuccess']) {
      showSnackBar(
        title: AppName,
        message: 'تم حفظ البيانات',
        snackbarStatus: () {
          btnController.reset();
          Get.find<HomeController>().selectindex.value = 1;
        },
      );
    } else {
      showSnackBar(
        title: AppName,
        message: 'خطاء فى البيانات المرسالة',
        snackbarStatus: () {
          btnController.reset();
        },
      );
    }
  }

  restBtn() {
    btnController.reset();
  }

  Future getOrder() async {
    Response response = await OrderProvider().getOrder();
    print(response.bodyString);
    if (response == null) {
      return Future.error('error');
    } else {
      final orderModel = orderModelFromJson(response.bodyString);
      return orderModel;
    }
  }

  Future getOrderDetailes(int OrderId) async {
    return await OrderProvider().getOrderDetailes(OrderId).then((response) {
      final oderDetaileModel = oderDetaileModelFromJson(response.bodyString);
      return oderDetaileModel;
    }, onError: (err) {
      return Future.error('error');
    });
  }

  addOffer({@required int orderId}) async {
    Response response = await OrderProvider().addOffer(
      orderId: orderId,
      name: offerName.text,
      price: double.parse(offerPrice.text.toString()),
    );

    if (response.hasError) {
    } else {
      if (response.body['IsSuccess']) {
        showSnackBar(
          title: AppName,
          message: 'تم الاضافة بنجاح',
          snackbarStatus: () {
            restBtn();
            getMerchantOffers(orderId: orderId);
            Get.back();
          },
        );
      } else {
        showSnackBar(
          title: AppName,
          message: 'خطاء فى اضافة البيانات',
          snackbarStatus: () {},
        );
      }
    }
  }

  Future getMerchantOffers({@required int orderId}) async {
    Response response = await OrderProvider().getMerchantOffers(orderId);
    final offerModel = offerModelFromJson(response.bodyString);
    return offerModel;
  }

  acceptOffer({@required int offerId}) async {
    Response response = await OrderProvider().acceptOffer(offerId);
    print(response.bodyString);
    return response;
  }


  
}
