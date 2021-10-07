// To parse this JSON data, do
//
//     final oderDetaileModel = oderDetaileModelFromJson(jsonString);

import 'dart:convert';

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
        this.statusName,
        this.lat,
        this.lng,
        this.distance,
        this.deliveryRate,
        this.merchantRate,
        this.merchantPhone,
        this.deliveryPhone,
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
    List<DeliveryOffer> deliveryOffers;
    String vanNumber;
    String description;
    String image;
    String statusName;
    double lat;
    double lng;
    double distance;
var merchantRate;
var deliveryRate;
var merchantPhone;
var deliveryPhone;

    factory OderDetaileModel.fromJson(Map<String, dynamic> json) => OderDetaileModel(
        id: json["Id"],
        userId: json["UserId"],
        userName: json["UserName"],
        markId: json["MarkId"],
        markName: json["MarkName"],
        modelId: json["ModelId"],
        modelName: json["ModelName"],
        versionId: json["VersionId"],
         merchantRate: json["MerchantRate"],
        deliveryRate: json["DeliveryRate"],
        date: DateTime.parse(json["Date"]),
        status: json["Status"],
        price: json["Price"].toDouble(),
        merchantOffers: List<MerchantOffer>.from(json["MerchantOffers"].map((x) => MerchantOffer.fromJson(x))),
        deliveryOffers: List<DeliveryOffer>.from(json["DeliveryOffers"].map((x) => DeliveryOffer.fromJson(x))),
        vanNumber: json["VanNumber"],
        description: json["Description"],
        image: json["Image"],
        statusName: json["StatusName"],
          merchantPhone: json["MerchantPhone"],
            deliveryPhone: json["DeliveryPhone"],
        lat: json["Lat"],
        lng: json["Lng"],
        distance: json["Distance"].toDouble(),
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
        "DeliveryOffers": List<dynamic>.from(deliveryOffers.map((x) => x.toJson())),
        "VanNumber": vanNumber,
        "Description": description,
        "Image": image,
        "StatusName": statusName,
        "Lat": lat,
        "Lng": lng,
        "Distance": distance,
    };
}

class DeliveryOffer {
    DeliveryOffer({
        this.id,
        this.status,
        this.orderId,
        this.userId,
        this.userName,
        this.date,
        this.price,
        this.statusName,
        this.name,
    });

    int id;
    int status;
    int orderId;
    String userId;
    String userName;
    DateTime date;
    double price;
    String statusName;
    String name;

    factory DeliveryOffer.fromJson(Map<String, dynamic> json) => DeliveryOffer(
        id: json["Id"],
        status: json["Status"],
        orderId: json["OrderId"],
        userId: json["UserId"] == null ? null : json["UserId"],
        userName: json["UserName"] == null ? null : json["UserName"],
        date: DateTime.parse(json["Date"]),
        price: json["Price"].toDouble(),
        statusName: json["StatusName"],
        name: json["Name"] == null ? null : json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Status": status,
        "OrderId": orderId,
        "UserId": userId == null ? null : userId,
        "UserName": userName == null ? null : userName,
        "Date": date.toIso8601String(),
        "Price": price,
        "StatusName": statusName,
        "Name": name == null ? null : name,
    };
}

class MerchantOffer {
    MerchantOffer({
        this.userId,
        this.userName,
        this.userAddress,
        this.lat,
        this.lng,
        this.details,
    });

    String userId;
    String userName;
    dynamic userAddress;
    double lat;
    double lng;
    List<DeliveryOffer> details;

    factory MerchantOffer.fromJson(Map<String, dynamic> json) => MerchantOffer(
        userId: json["UserId"],
        userName: json["UserName"],
        userAddress: json["UserAddress"],
        lat: json["Lat"].toDouble(),
        lng: json["Lng"].toDouble(),
        details: List<DeliveryOffer>.from(json["Details"].map((x) => DeliveryOffer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "UserId": userId,
        "UserName": userName,
        "UserAddress": userAddress,
        "Lat": lat,
        "Lng": lng,
        "Details": List<dynamic>.from(details.map((x) => x.toJson())),
    };
}
