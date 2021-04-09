// To parse this JSON data, do
//
//     final notifactionModel = notifactionModelFromJson(jsonString);

import 'dart:convert';

List<NotifactionModel> notifactionModelFromJson(String str) => List<NotifactionModel>.from(json.decode(str).map((x) => NotifactionModel.fromJson(x)));

String notifactionModelToJson(List<NotifactionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotifactionModel {
    NotifactionModel({
        this.id,
        this.name,
        this.body,
        this.userId,
        this.fromUserId,
        this.fromUserName,
        this.date,
        this.typeId,
        this.isRead,
        this.refId,
        this.userIds,
        this.link,
    });

    int id;
    dynamic name;
    dynamic body;
    String userId;
    String fromUserId;
    String fromUserName;
    DateTime date;
    int typeId;
    bool isRead;
    int refId;
    dynamic userIds;
    dynamic link;

    factory NotifactionModel.fromJson(Map<String, dynamic> json) => NotifactionModel(
        id: json["Id"],
        name: json["Name"],
        body: json["Body"],
        userId: json["UserId"],
        fromUserId: json["FromUserId"],
        fromUserName: json["FromUserName"],
        date: DateTime.parse(json["Date"]),
        typeId: json["TypeId"],
        isRead: json["IsRead"],
        refId: json["RefId"],
        userIds: json["UserIds"],
        link: json["Link"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Body": body,
        "UserId": userId,
        "FromUserId": fromUserId,
        "FromUserName": fromUserName,
        "Date": date.toIso8601String(),
        "TypeId": typeId,
        "IsRead": isRead,
        "RefId": refId,
        "UserIds": userIds,
        "Link": link,
    };
}
