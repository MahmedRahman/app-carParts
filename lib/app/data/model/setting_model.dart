// To parse this JSON data, do
//
//     final settingModel = settingModelFromJson(jsonString);

import 'dart:convert';

SettingModel settingModelFromJson(String str) => SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel {
    SettingModel({
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
    });

    int id;
    double tax;
    double kmPriceMin;
    double kmPriceMax;
    String whatsUpNumber;
    String helpPhoneNumber;
    String logo;
    dynamic logoFile;
    String facebook;
    String twitter;
    String googlePlus;
    String instagram;
    String linkedIn;
    String pinterest;
    String snapchat;
    String youTube;
    String tikTok;
    String telegram;
    String about;
    String terms;
    String callUs;

    factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
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
    };
}
