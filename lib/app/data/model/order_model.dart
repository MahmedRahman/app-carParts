// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
    OrderModel({
        this.id,
        this.userId,
        this.userName,
        this.markId,
        this.markName,
        this.modelId,
        this.modelName,
        this.versionId,
        this.versionName,
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
    dynamic markName;
    int modelId;
    dynamic modelName;
    int versionId;
    dynamic versionName;
    DateTime date;
    int status;
    double price;
    List<dynamic> merchantOffers;
    List<dynamic> deliveryOffers;
    String vanNumber;
    String description;
    dynamic image;
    dynamic imageFile;
    dynamic imageBytes;

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["Id"],
        userId: json["UserId"],
        userName: json["UserName"],
        markId: json["MarkId"],
        markName: json["MarkName"],
        modelId: json["ModelId"],
        modelName: json["ModelName"],
        versionId: json["VersionId"],
        versionName: json["VersionName"],
        date: DateTime.parse(json["Date"]),
        status: json["Status"],
        price: json["Price"],
        merchantOffers: List<dynamic>.from(json["MerchantOffers"].map((x) => x)),
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
        "VersionName": versionName,
        "Date": date.toIso8601String(),
        "Status": status,
        "Price": price,
        "MerchantOffers": List<dynamic>.from(merchantOffers.map((x) => x)),
        "DeliveryOffers": List<dynamic>.from(deliveryOffers.map((x) => x)),
        "VanNumber": vanNumber,
        "Description": description,
        "Image": image,
        "ImageFile": imageFile,
        "ImageBytes": imageBytes,
    };
}
