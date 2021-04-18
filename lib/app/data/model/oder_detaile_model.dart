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
        this.imageFile,
        this.imageBytes,
        this.statusName,
        this.lat,
        this.lng,
        this.distance,
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
    List<Offer> merchantOffers;
    List<Offer> deliveryOffers;
    String vanNumber;
    String description;
    String image ='';
    dynamic imageFile;
    dynamic imageBytes;
    String statusName;
    double lat;
    double lng;
    double distance;

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
        merchantOffers: List<Offer>.from(json["MerchantOffers"].map((x) => Offer.fromJson(x))),
        deliveryOffers: List<Offer>.from(json["DeliveryOffers"].map((x) => Offer.fromJson(x))),
        vanNumber: json["VanNumber"],
        description: json["Description"],
        image: json["Image"],
        imageFile: json["ImageFile"],
        imageBytes: json["ImageBytes"],
        statusName: json["StatusName"],
        lat: json["Lat"].toDouble(),
        lng: json["Lng"].toDouble(),
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
        "ImageFile": imageFile,
        "ImageBytes": imageBytes,
        "StatusName": statusName,
        "Lat": lat,
        "Lng": lng,
        "Distance": distance,
    };
}

class Offer {
    Offer({
        this.id,
        this.status,
        this.orderId,
        this.userId,
        this.userName,
        this.date,
        this.price,
        this.statusName,
        this.userAddress,
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
    dynamic userAddress;
    String name;

    factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["Id"],
        status: json["Status"],
        orderId: json["OrderId"],
        userId: json["UserId"],
        userName: json["UserName"],
        date: DateTime.parse(json["Date"]),
        price: json["Price"],
        statusName: json["StatusName"],
        userAddress: json["UserAddress"],
        name: json["Name"] == null ? null : json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Status": status,
        "OrderId": orderId,
        "UserId": userId,
        "UserName": userName,
        "Date": date.toIso8601String(),
        "Price": price,
        "StatusName": statusName,
        "UserAddress": userAddress,
        "Name": name == null ? null : name,
    };
}
