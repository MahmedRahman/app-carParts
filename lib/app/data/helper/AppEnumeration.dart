import 'package:get/get.dart';

var carMark = [];
var carModel = [];
var cityName = [];
var bankName = [];
var Cars = [];

var verisionYears = [
  '2021', '2020', '2019', '2018'
  //, '2017' , '2016' , '2015' ,'2014' ,'2013' ,'2012'
];

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

var NotifactionCount = 0.obs;

String Kwhatapp = '';
String KTwitter = '';
String KInstegram = '';
String KSnapChat = '';

enum userRole { Client, Merchant, DeliveryAgent, anonymous }

var KName = ''.obs;
var KRate = 0.obs;
var KEmail = ''.obs;
var KOrderCount = ''.obs;
var KUserImage = ''.obs;
var KMerchantOfferImage = ''.obs;

var Kselectindex = 0.obs;
var KCity = ''.obs;
var Ktax;

var KAdress = ''.obs;

String KFirebaseMessagingToken = '';

userRole KRole = userRole.anonymous;

enum OrderStatus {
  Request,
  MerchantOffer,
  MerchantOfferComplete,
  SetLocation,
  DeliveryAgentOffer,
  DeliveryAgentOfferComplete,
  Paid,
  MerchantGivePart,
  DeliveryGetPart,
  DeliveryGivePart,
  Complete,
  Delete,
}

enum RequestStatus { Request, Accept, Refuse }
