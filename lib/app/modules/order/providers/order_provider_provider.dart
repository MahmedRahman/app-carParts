import 'dart:io';

import 'package:carpart/app/data/repostory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderProvider extends RepostoryProvide {
  createorder({
    @required int markid,
    @required int modelId,
    @required String versionId,
    @required String vanNumber,
    @required String description,
    String imageBytes,
  }) async {
    Response response = await repPost('Order/Add', {
      "MarkId": markid,
      "ModelId": modelId,
      "VersionId": versionId,
      "VanNumber": vanNumber,
      "Description": description,
      "ImageBytes": imageBytes.toString()
    });

    return response;
  }

  getOrder() async {
    return await repGet('Order/Get').then((response) {
      return response;
    }, onError: (err) {
      return null;
    });
  }

  Future getOrderDetailes(int OrderId) async {
    Response response = await repGet('Order/Get/$OrderId').then((response) {
      return response;
    }, onError: (err) {
      return null;
    });

    print(response.bodyString);
    return response;
  }

  addOffer({
    @required int orderId,
    @required String name,
    @required double price,
  }) async {
    Response response = await repPost('MerchantOffer/Add',
        {"OrderId": orderId, "Name": name, "Price": price});

    return response;
  }

  getMerchantOffers(int OrderId) async {
    Response response =
        await repGet('MerchantOffer/Getall/' + OrderId.toString());
    return response;
  }

  acceptOffer(int offerid) async {
    Response response =
        await repPost('MerchantOffer/Accept/' + offerid.toString(),null);
    return response;
  }
}
