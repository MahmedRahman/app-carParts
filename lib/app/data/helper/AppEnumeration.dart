var carMark = [];
var carModel = [];
var cityName = [];
var bankName = [];

Future pageAbout;
Future pageCallus;
Future pageTream;
String helpPhoneNumber;

enum userRole { Client, Merchant, DeliveryAgent, anonymous }

String KName = '';
String KEmail = '';
String KCity = '';

userRole KRole = userRole.anonymous;

enum OrderStatus {
  Request,
  MerchantOffer,
  MerchantOfferComplete,
  DeliveryAgentOffer,
  DeliveryAgentOfferComplete
}

enum RequestStatus { Request, Accept, Refuse }
