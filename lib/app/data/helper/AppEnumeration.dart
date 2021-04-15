var carMark = [];
var carModel = [];
var cityName = [];
var bankName = [];

Future pageAbout;
Future pageCallus;
Future pageTream;
String helpPhoneNumber;


double KMPriceMin;
double KMPriceMax;

double Klatitude = 24.713552;
double Klongitude = 46.675297;

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
