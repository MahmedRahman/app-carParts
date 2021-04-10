// To parse this JSON data, do
//
//     final userBankModel = userBankModelFromJson(jsonString);

import 'dart:convert';

List<UserBankModel> userBankModelFromJson(String str) => List<UserBankModel>.from(json.decode(str).map((x) => UserBankModel.fromJson(x)));

String userBankModelToJson(List<UserBankModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserBankModel {
    UserBankModel({
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

    factory UserBankModel.fromJson(Map<String, dynamic> json) => UserBankModel(
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
