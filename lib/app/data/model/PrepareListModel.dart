// To parse this JSON data, do
//
//     final prepareListModel = prepareListModelFromJson(jsonString);

import 'dart:convert';

PrepareListModel prepareListModelFromJson(String str) =>
    PrepareListModel.fromJson(json.decode(str));

String prepareListModelToJson(PrepareListModel data) =>
    json.encode(data.toJson());

class PrepareListModel {
  PrepareListModel({
    this.mark,
    this.cities,
    this.setting,
    this.bank,
  });

  List<Mark> mark;
  List<City> cities;
  Setting setting;
  List<Bank> bank;

  factory PrepareListModel.fromJson(Map<String, dynamic> json) =>
      PrepareListModel(
        mark: List<Mark>.from(json["Mark"].map((x) => Mark.fromJson(x))),
        cities: List<City>.from(json["Cities"].map((x) => City.fromJson(x))),
        setting: Setting.fromJson(json["Setting"]),
        bank: List<Bank>.from(json["Bank"].map((x) => Bank.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Mark": List<dynamic>.from(mark.map((x) => x.toJson())),
        "Cities": List<dynamic>.from(cities.map((x) => x.toJson())),
        "Setting": setting.toJson(),
        "Bank": List<dynamic>.from(bank.map((x) => x.toJson())),
      };
}

class Bank {
  Bank({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["Id"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}

class City {
  City({
    this.id,
    this.name,
    this.lat,
    this.lng,
  });

  int id;
  String name;
  double lat;
  double lng;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["Id"],
        name: json["Name"],
        lat: json["Lat"].toDouble(),
        lng: json["Lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Lat": lat,
        "Lng": lng,
      };
}

class Mark {
  Mark({
    this.id,
    this.name,
    this.models,
  });

  int id;
  String name;
  List<Model> models;

  factory Mark.fromJson(Map<String, dynamic> json) => Mark(
        id: json["Id"],
        name: json["Name"],
        models: List<Model>.from(json["Models"].map((x) => Model.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Models": List<dynamic>.from(models.map((x) => x.toJson())),
      };
}

class Model {
  Model({
    this.id,
    this.name,
    this.markId,
    this.markName,
  });

  int id;
  String name;
  int markId;
  dynamic markName;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json["Id"],
        name: json["Name"],
        markId: json["MarkId"],
        markName: json["MarkName"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "MarkId": markId,
        "MarkName": markName,
      };
}

class Setting {
  Setting({
    this.id,
    this.tax,
    this.kmPriceMin,
    this.kmPriceMax,
    this.whatsUpNumber,
    this.helpPhoneNumber,
    this.logo,
    this.logoFile,
    this.facebook,
    this.twitter,
    this.googlePlus,
    this.instagram,
    this.linkedIn,
    this.pinterest,
    this.snapchat,
    this.youTube,
    this.tikTok,
    this.telegram,
    this.about,
    this.terms,
    this.callUs,
    this.BaseDeliveryPrice,
    this.AdministrativeFees,
  });

  int id;
  double tax;
  dynamic kmPriceMin;
  dynamic kmPriceMax;
  String whatsUpNumber;
  String helpPhoneNumber;
  String logo;
  dynamic logoFile;
  dynamic facebook;
  dynamic twitter;
  dynamic googlePlus;
  dynamic instagram;
  dynamic linkedIn;
  dynamic pinterest;
  dynamic snapchat;
  dynamic youTube;
  dynamic tikTok;
  dynamic telegram;
  String about;
  String terms;
  String callUs;
  double BaseDeliveryPrice;
  double AdministrativeFees;

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        id: json["Id"],
        tax: json["Tax"],
        kmPriceMin: json["KMPriceMin"],
        kmPriceMax: json["KMPriceMax"],
        whatsUpNumber: json["WhatsUpNumber"],
        helpPhoneNumber: json["HelpPhoneNumber"],
        logo: json["Logo"],
        logoFile: json["LogoFile"],
        facebook: json["Facebook"],
        twitter: json["Twitter"],
        googlePlus: json["GooglePlus"],
        instagram: json["Instagram"],
        linkedIn: json["LinkedIn"],
        pinterest: json["Pinterest"],
        snapchat: json["Snapchat"],
        youTube: json["YouTube"],
        tikTok: json["TikTok"],
        telegram: json["Telegram"],
        about: json["About"],
        terms: json["Terms"],
        callUs: json["CallUs"],
        BaseDeliveryPrice: json["BaseDeliveryPrice"],
AdministrativeFees: json["AdministrativeFees"],
        
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Tax": tax,
        "KMPriceMin": kmPriceMin,
        "KMPriceMax": kmPriceMax,
        "WhatsUpNumber": whatsUpNumber,
        "HelpPhoneNumber": helpPhoneNumber,
        "Logo": logo,
        "LogoFile": logoFile,
        "Facebook": facebook,
        "Twitter": twitter,
        "GooglePlus": googlePlus,
        "Instagram": instagram,
        "LinkedIn": linkedIn,
        "Pinterest": pinterest,
        "Snapchat": snapchat,
        "YouTube": youTube,
        "TikTok": tikTok,
        "Telegram": telegram,
        "About": about,
        "Terms": terms,
        "CallUs": callUs,
        "BaseDeliveryPrice": BaseDeliveryPrice,
         "AdministrativeFees": AdministrativeFees,
      };
}
