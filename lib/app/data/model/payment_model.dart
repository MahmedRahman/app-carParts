// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

List<PaymentModel> paymentModelFromJson(String str) => List<PaymentModel>.from(json.decode(str).map((x) => PaymentModel.fromJson(x)));

String paymentModelToJson(List<PaymentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentModel {
    PaymentModel({
        this.id,
        this.date,
        this.userId,
        this.userName,
        this.price,
        this.status,
    });

    int id;
    DateTime date;
    String userId;
    String userName;
    double price;
    int status;

    factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["Id"],
        date: DateTime.parse(json["Date"]),
        userId: json["UserId"],
        userName: json["UserName"],
        price: json["Price"],
        status: json["Status"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Date": date.toIso8601String(),
        "UserId": userId,
        "UserName": userName,
        "Price": price,
        "Status": status,
    };
}
