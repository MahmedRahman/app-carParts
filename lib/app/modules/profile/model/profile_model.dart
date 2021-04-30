// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    ProfileModel({
        this.id,
        this.name,
        this.address,
        this.email,
        this.userName,
        this.phoneNumber,
        this.password,
        this.confirmPassword,
        this.lat,
        this.lng,
        this.deviceId,
        this.cityId,
        this.cityName,
        this.logo,
        this.logoBytes,
        this.logoFile,
        this.addedDate,
        this.nationalNumber,
        this.businessName,
        this.registrationImage,
        this.registrationImageBytes,
        this.registrationFile,
        this.nationalIdImage,
        this.nationalIdBytes,
        this.nationalIdFile,
        this.drivingLicenseImage,
        this.drivingLicenseBytes,
        this.drivingLicenseFile,
        this.carFrontImage,
        this.carFrontBytes,
        this.carFrontFile,
        this.carBackImage,
        this.carBackBytes,
        this.carBackFile,
        this.carPaperImage,
        this.carPaperFile,
        this.carPaperBytes,
        this.balance,
        this.paidBalance,
        this.roleName,
        this.role,
        this.marksId,
        this.marks,
        this.marksJson,
        this.unreadNotificationCount,
        this.rate,
    });

    String id;
    String name;
    dynamic address;
    String email;
    String userName;
    String phoneNumber;
    dynamic password;
    dynamic confirmPassword;
    double lat;
    double lng;
    String deviceId;
    int cityId;
    String cityName;
    String logo;
    dynamic logoBytes;
    dynamic logoFile;
    DateTime addedDate;
    dynamic nationalNumber;
    dynamic businessName;
    dynamic registrationImage;
    dynamic registrationImageBytes;
    dynamic registrationFile;
    dynamic nationalIdImage;
    dynamic nationalIdBytes;
    dynamic nationalIdFile;
    dynamic drivingLicenseImage;
    dynamic drivingLicenseBytes;
    dynamic drivingLicenseFile;
    dynamic carFrontImage;
    dynamic carFrontBytes;
    dynamic carFrontFile;
    dynamic carBackImage;
    dynamic carBackBytes;
    dynamic carBackFile;
    dynamic carPaperImage;
    dynamic carPaperFile;
    dynamic carPaperBytes;
    int balance;
    int paidBalance;
    String roleName;
    int role;
    List<dynamic> marksId;
    List<dynamic> marks;
    dynamic marksJson;
    int unreadNotificationCount;
    int rate;

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["Id"],
        name: json["Name"],
        address: json["Address"],
        email: json["Email"],
        userName: json["UserName"],
        phoneNumber: json["PhoneNumber"],
        password: json["Password"],
        confirmPassword: json["ConfirmPassword"],
        lat: json["Lat"].toDouble(),
        lng: json["Lng"].toDouble(),
        deviceId: json["DeviceId"],
        cityId: json["CityId"],
        cityName: json["CityName"],
        logo: json["Logo"],
        logoBytes: json["LogoBytes"],
        logoFile: json["LogoFile"],
        addedDate: DateTime.parse(json["AddedDate"]),
        nationalNumber: json["NationalNumber"],
        businessName: json["BusinessName"],
        registrationImage: json["RegistrationImage"],
        registrationImageBytes: json["RegistrationImageBytes"],
        registrationFile: json["RegistrationFile"],
        nationalIdImage: json["NationalIdImage"],
        nationalIdBytes: json["NationalIdBytes"],
        nationalIdFile: json["NationalIdFile"],
        drivingLicenseImage: json["DrivingLicenseImage"],
        drivingLicenseBytes: json["DrivingLicenseBytes"],
        drivingLicenseFile: json["DrivingLicenseFile"],
        carFrontImage: json["CarFrontImage"],
        carFrontBytes: json["CarFrontBytes"],
        carFrontFile: json["CarFrontFile"],
        carBackImage: json["CarBackImage"],
        carBackBytes: json["CarBackBytes"],
        carBackFile: json["CarBackFile"],
        carPaperImage: json["CarPaperImage"],
        carPaperFile: json["CarPaperFile"],
        carPaperBytes: json["CarPaperBytes"],
        balance: json["Balance"],
        paidBalance: json["PaidBalance"],
        roleName: json["RoleName"],
        role: json["Role"],
        marksId: List<dynamic>.from(json["MarksId"].map((x) => x)),
        marks: List<dynamic>.from(json["Marks"].map((x) => x)),
        marksJson: json["MarksJson"],
        unreadNotificationCount: json["UnreadNotificationCount"],
        rate: json["Rate"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Address": address,
        "Email": email,
        "UserName": userName,
        "PhoneNumber": phoneNumber,
        "Password": password,
        "ConfirmPassword": confirmPassword,
        "Lat": lat,
        "Lng": lng,
        "DeviceId": deviceId,
        "CityId": cityId,
        "CityName": cityName,
        "Logo": logo,
        "LogoBytes": logoBytes,
        "LogoFile": logoFile,
        "AddedDate": '',
        "NationalNumber": nationalNumber,
        "BusinessName": businessName,
        "RegistrationImage": registrationImage,
        "RegistrationImageBytes": registrationImageBytes,
        "RegistrationFile": registrationFile,
        "NationalIdImage": nationalIdImage,
        "NationalIdBytes": nationalIdBytes,
        "NationalIdFile": nationalIdFile,
        "DrivingLicenseImage": drivingLicenseImage,
        "DrivingLicenseBytes": drivingLicenseBytes,
        "DrivingLicenseFile": drivingLicenseFile,
        "CarFrontImage": carFrontImage,
        "CarFrontBytes": carFrontBytes,
        "CarFrontFile": carFrontFile,
        "CarBackImage": carBackImage,
        "CarBackBytes": carBackBytes,
        "CarBackFile": carBackFile,
        "CarPaperImage": carPaperImage,
        "CarPaperFile": carPaperFile,
        "CarPaperBytes": carPaperBytes,
        "Balance": balance,
        "PaidBalance": paidBalance,
        "RoleName": roleName,
        "Role": role,
        "MarksId":[],
        "Marks": [],
        "MarksJson": marksJson,
        "UnreadNotificationCount": unreadNotificationCount,
        "Rate": rate,
    };
}
