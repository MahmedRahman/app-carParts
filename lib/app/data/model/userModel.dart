// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.accessToken,
        this.tokenType,
        this.expiresIn,
        this.userName,
        this.issued,
        this.expires,
        this.role,
    });

    String accessToken;
    String tokenType;
    int expiresIn;
    String userName;
    String issued;
    String expires;
    String role;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        userName: json["userName"],
        issued: json[".issued"],
        expires: json[".expires"],
        role: json["Role"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "userName": userName,
        ".issued": issued,
        ".expires": expires,
        "Role": role,
    };
}
