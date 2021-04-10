import 'package:get/get.dart';

import 'package:carpart/app/modules/authiocation/bindings/authiocation_binding.dart';
import 'package:carpart/app/modules/authiocation/views/authiocation_view.dart';
import 'package:carpart/app/modules/authiocation/views/frogatepassword_view.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/modules/authiocation/views/signup_dealer_view.dart';
import 'package:carpart/app/modules/authiocation/views/signup_delivery_view.dart';
import 'package:carpart/app/modules/authiocation/views/signup_view.dart';
import 'package:carpart/app/modules/authiocation/views/signup_complate_view.dart';
import 'package:carpart/app/modules/authiocation/views/splash_view.dart';
import 'package:carpart/app/modules/bank/add/bindings/bank_add_binding.dart';
import 'package:carpart/app/modules/bank/add/views/bank_add_view.dart';
import 'package:carpart/app/modules/bank/list/bindings/bank_list_binding.dart';
import 'package:carpart/app/modules/bank/list/views/bank_list_view.dart';
import 'package:carpart/app/modules/entry_point/bindings/entry_point_binding.dart';
import 'package:carpart/app/modules/entry_point/views/entry_point_view.dart';
import 'package:carpart/app/modules/home/bindings/home_binding.dart';
import 'package:carpart/app/modules/home/views/home_view.dart';
import 'package:carpart/app/modules/notifaction/bindings/notifaction_binding.dart';
import 'package:carpart/app/modules/notifaction/views/notifaction_view.dart';
import 'package:carpart/app/modules/order/bindings/order_binding.dart';
import 'package:carpart/app/modules/order/views/order_create_view.dart';
import 'package:carpart/app/modules/order/views/order_detailes_view.dart';
import 'package:carpart/app/modules/order/views/order_view.dart';
import 'package:carpart/app/modules/page/bindings/page_binding.dart';
import 'package:carpart/app/modules/page/views/about_view.dart';
import 'package:carpart/app/modules/page/views/contactus_view.dart';
import 'package:carpart/app/modules/page/views/page_view.dart';
import 'package:carpart/app/modules/page/views/trems_view.dart';
import 'package:carpart/app/modules/payment/add/bindings/payment_add_binding.dart';
import 'package:carpart/app/modules/payment/add/views/payment_add_view.dart';
import 'package:carpart/app/modules/payment/list/bindings/payment_list_binding.dart';
import 'package:carpart/app/modules/payment/list/views/payment_list_view.dart';
import 'package:carpart/app/modules/profile/bindings/profile_binding.dart';
import 'package:carpart/app/modules/profile/views/profile_view.dart';
import 'package:carpart/app/modules/stoperror/bindings/stoperror_binding.dart';
import 'package:carpart/app/modules/stoperror/views/stoperror_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.ENTRY_POINT;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.AUTHIOCATION,
      page: () => AuthiocationView(),
      binding: AuthiocationBinding(),
    ),
    GetPage(
      name: Routes.SplashView,
      page: () => SplashView(),
      binding: AuthiocationBinding(),
    ),
    GetPage(
      name: Routes.SigninView,
      page: () => SigninView(),
      binding: AuthiocationBinding(),
    ),
    GetPage(
      name: Routes.SignupDeliveryView,
      page: () => SignupDeliveryView(),
      binding: AuthiocationBinding(),
    ),
    GetPage(
      name: Routes.SignupDealerView,
      page: () => SignupDealerView(),
      binding: AuthiocationBinding(),
    ),
    GetPage(
      name: Routes.SignupView,
      page: () => SignupView(),
      binding: AuthiocationBinding(),
    ),
    GetPage(
      name: Routes.FrogatepasswordView,
      page: () => FrogatepasswordView(),
      binding: AuthiocationBinding(),
    ),
    GetPage(
      name: Routes.SignupcomplateView,
      page: () => SignupcomplateView(),
      binding: AuthiocationBinding(),
    ),
    GetPage(
      name: Routes.PAGE,
      page: () => PageView(),
      binding: PageBinding(),
    ),
    GetPage(
      name: Routes.AboutView,
      page: () => AboutView(),
      binding: PageBinding(),
    ),
    GetPage(
      name: Routes.ContactusView,
      page: () => ContactusView(),
      binding: PageBinding(),
    ),
    GetPage(
      name: Routes.TremsView,
      page: () => TremsView(),
      binding: PageBinding(),
    ),
    GetPage(
      name: Routes.NOTIFACTION,
      page: () => NotifactionView(),
      binding: NotifactionBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.ORDER,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: Routes.OrderDetailesView,
      page: () => OrderDetailesView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: Routes.OrderCreateView,
      page: () => OrderCreateView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: Routes.ENTRY_POINT,
      page: () => EntryPointView(),
      binding: EntryPointBinding(),
    ),
    GetPage(
      name: Routes.BANK_LIST,
      page: () => BankListView(),
      binding: BankListBinding(),
    ),
    GetPage(
      name: Routes.BANK_ADD,
      page: () => BankAddView(),
      binding: BankAddBinding(),
    ),
    GetPage(
      name: Routes.PAYMENT_LIST,
      page: () => PaymentListView(),
      binding: PaymentListBinding(),
    ),
    GetPage(
      name: Routes.PAYMENT_ADD,
      page: () => PaymentAddView(),
      binding: PaymentAddBinding(),
    ),
    GetPage(
      name: Routes.STOPERROR,
      page: () => StoperrorView(),
      binding: StoperrorBinding(),
    ),
  ];
}
