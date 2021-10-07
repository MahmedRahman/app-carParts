// To parse this JSON data, do
//
//     final offerModel = offerModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

List<OfferModel> offerModelFromJson(String str) => List<OfferModel>.from(json.decode(str).map((x) => OfferModel.fromJson(x)));

String offerModelToJson(List<OfferModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OfferModel {
    OfferModel({
        this.id,
        this.orderId,
        this.date,
        this.status,
        this.userId,
        this.userName,
        this.name,
        this.image,
        this.price,
    });

    int id;
    int orderId;
    DateTime date;
    int status;
    String userId;
    String userName;
    String name;
       String image;
    double price;

    factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json["Id"],
        orderId: json["OrderId"],
        date: DateTime.parse(json["Date"]),
        status: json["Status"],
        userId: json["UserId"],
        userName: json["UserName"],
        name: json["Name"],
        image: json["image"],
        price: json["Price"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "OrderId": orderId,
        "Date": GetUtils.isNullOrBlank(date)? DateTime.now().toIso8601String() :date.toIso8601String(),
        "Status": status,
        "UserId": userId,
        "UserName": userName,
        "Name": name,
        "ImageBytes": image,
        "Price": price,
    };
}
