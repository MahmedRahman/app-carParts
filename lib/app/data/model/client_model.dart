// To parse this JSON data, do
//
//     final clientModel = clientModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ClientModel clientModelFromJson(String str) => ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientModel {
    ClientModel({
        @required this.name,
        @required this.phoneNumber,
        @required this.userName,
        @required this.password,
        @required this.confirmPassword,
        @required this.email,
        @required this.logo,
        @required this.logoFile,
        @required this.cityId,
        @required this.lat,
        @required this.lng,
        @required this.deviceId,
    });

    String name;
    String phoneNumber;
    String userName;
    String password;
    String confirmPassword;
    String email;
    String logo;
    dynamic logoFile;
    int cityId;
    double lat;
    double lng;
    String deviceId;

    factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        name: json["Name"],
        phoneNumber: json["PhoneNumber"],
        userName: json["UserName"],
        password: json["Password"],
        confirmPassword: json["ConfirmPassword"],
        email: json["Email"],
        logo: json["Logo"],
        logoFile: json["LogoFile"],
        cityId: json["CityId"],
        lat: json["Lat"].toDouble(),
        lng: json["Lng"].toDouble(),
        deviceId: json["DeviceId"],
    );

    Map<String, dynamic> toJson() => {
        "Name": name,
        "PhoneNumber": phoneNumber,
        "UserName": userName,
        "Password": password,
        "ConfirmPassword": confirmPassword,
        "Email": email,
        "Logo": logo,
        "LogoFile": logoFile,
        "CityId": cityId,
        "Lat": lat,
        "Lng": lng,
        "DeviceId": deviceId,
    };
}
