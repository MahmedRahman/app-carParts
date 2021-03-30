import 'package:carpart/app/data/repostory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderProvider extends RepostoryProvide {
  createorder({
    @required int markid,
    @required int modelId,
    @required int versionId,
    @required String vanNumber,
    @required String description,
  }) async {
    Response response = await repPost('Order/Add', {
      "MarkId": 1,
      "ModelId": 1,
      "VersionId": 1,
      "VanNumber": "123456",
      "Description": "Mahemd sss"
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
}
