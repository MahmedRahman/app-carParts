var carMark = [];
var carModel = [];
var cityName = [];
var bankName = [];
var Cars = [];
/*
var Cars = [
  {
    "Id": 1,
    "Name": "فيات",
    "Models": [
      {"Id": 1, "Name": "تيبو", "MarkId": 1, "MarkName": null},
      {"Id": 2, "Name": "128", "MarkId": 1, "MarkName": null}
    ]
  },
  {
    "Id": 2,
    "Name": "رينو",
    "Models": [
      {"Id": 3, "Name": "ميجان", "MarkId": 2, "MarkName": null},
      {"Id": 4, "Name": "لوجان", "MarkId": 2, "MarkName": null}
    ]
  }
];
*/
Future pageAbout;
Future pageCallus;
Future pageTream;
String helpPhoneNumber;

double KMPriceMin;
double KMPriceMax;
double KBalance;
double KPaidBalance;

double Klatitude = 24.713552;
double Klongitude = 46.675297;
double BaseDeliveryPrice;
double KAdministrativeFees;

enum userRole { Client, Merchant, DeliveryAgent, anonymous }

String KName = '';
String KEmail = '';
String KCity = '';
String KFirebaseMessagingToken = '';

userRole KRole = userRole.anonymous;

enum OrderStatus {
  Request,
  MerchantOffer,
  MerchantOfferComplete,
  DeliveryAgentOffer,
  DeliveryAgentOfferComplete,
  Paid,
  MerchantGivePart,
  DeliveryGetPart,
  Complete,
}

enum RequestStatus { Request, Accept, Refuse }
