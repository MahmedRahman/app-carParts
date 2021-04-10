// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

List<BankModel> bankModelFromJson(String str) => List<BankModel>.from(json.decode(str).map((x) => BankModel.fromJson(x)));

String bankModelToJson(List<BankModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankModel {
    BankModel({
        this.id,
        this.userId,
        this.userName,
        this.bankId,
        this.bankName,
        this.iban,
    });

    int id;
    String userId;
    dynamic userName;
    int bankId;
    String bankName;
    String iban;

    factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        id: json["Id"],
        userId: json["UserId"],
        userName: json["UserName"],
        bankId: json["BankId"],
        bankName: json["BankName"],
        iban: json["IBAN"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "UserName": userName,
        "BankId": bankId,
        "BankName": bankName,
        "IBAN": iban,
    };
}
