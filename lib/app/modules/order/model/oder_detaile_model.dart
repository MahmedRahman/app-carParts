// To parse this JSON data, do
//
//     final oderDetaileModel = oderDetaileModelFromJson(jsonString);

import 'dart:convert';

import 'package:carpart/app/data/helper/AppEnumeration.dart';

OderDetaileModel oderDetaileModelFromJson(String str) => OderDetaileModel.fromJson(json.decode(str));

String oderDetaileModelToJson(OderDetaileModel data) => json.encode(data.toJson());

class OderDetaileModel {
    OderDetaileModel({
        this.id,
        this.userId,
        this.userName,
        this.markId,
        this.markName,
        this.modelId,
        this.modelName,
        this.versionId,
        this.date,
        this.status,
        this.price,
        this.merchantOffers,
        this.deliveryOffers,
        this.vanNumber,
        this.description,
        this.image,
        this.imageFile,
        this.imageBytes,
    });

    int id;
    String userId;
    String userName;
    int markId;
    String markName;
    int modelId;
    String modelName;
    int versionId;
    DateTime date;
    int status;
    double price;
    List<MerchantOffer> merchantOffers;
    List<dynamic> deliveryOffers;
    String vanNumber;
    String description;
    String image;
    dynamic imageFile;
    dynamic imageBytes;

    factory OderDetaileModel.fromJson(Map<String, dynamic> json) => OderDetaileModel(
        id: json["Id"],
        userId: json["UserId"],
        userName: json["UserName"],
        markId: json["MarkId"],
        markName: json["MarkName"],
        modelId: json["ModelId"],
        modelName: json["ModelName"],
        versionId: json["VersionId"],
        date: DateTime.parse(json["Date"]),
        status: json["Status"],
        price: json["Price"],
        merchantOffers: List<MerchantOffer>.from(json["MerchantOffers"].map((x) => MerchantOffer.fromJson(x))),
        deliveryOffers: List<dynamic>.from(json["DeliveryOffers"].map((x) => x)),
        vanNumber: json["VanNumber"],
        description: json["Description"],
        image: json["Image"],
        imageFile: json["ImageFile"],
        imageBytes: json["ImageBytes"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "UserName": userName,
        "MarkId": markId,
        "MarkName": markName,
        "ModelId": modelId,
        "ModelName": modelName,
        "VersionId": versionId,
        "Date": date.toIso8601String(),
        "Status": status,
        "Price": price,
        "MerchantOffers": List<dynamic>.from(merchantOffers.map((x) => x.toJson())),
        "DeliveryOffers": List<dynamic>.from(deliveryOffers.map((x) => x)),
        "VanNumber": vanNumber,
        "Description": description,
        "Image": image,
        "ImageFile": imageFile,
        "ImageBytes": imageBytes,
    };
}

class MerchantOffer {
    MerchantOffer({
        this.id,
        this.orderId,
        this.date,
        this.status,
        this.userId,
        this.userName,
        this.name,
        this.price,
    });

    int id;
    int orderId;
    DateTime date;
    int status;
    String userId;
    String userName;
    String name;
    double price;

    factory MerchantOffer.fromJson(Map<String, dynamic> json) => MerchantOffer(
        id: json["Id"],
        orderId: json["OrderId"],
        date: DateTime.parse(json["Date"]),
        status: json["Status"],
        userId: json["UserId"],
        userName: json["UserName"],
        name: json["Name"],
        price: json["Price"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "OrderId": orderId,
        "Date": date.toIso8601String(),
        "Status": status,
        "UserId": userId,
        "UserName": userName,
        "Name": name,
        "Price": price,
    };
}
