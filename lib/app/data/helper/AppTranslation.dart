import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'ar_EG': {
          'skip': 'تخطى',
          'lang': 'English',
          'Done': 'موافق',
          'OrderStatus.Request': 'جديد',
          'OrderStatus.MerchantOffer': 'عروض تجار',
          'OrderStatus.MerchantOfferComplete': 'عرض تاجر مكتمل',
          'OrderStatus.DeliveryAgentOffer': 'عروض توصيل',
          'OrderStatus.DeliveryAgentOfferComplete': 'عرض توصيل مكتمل',
          'userRole.Client': 'مشترى',
          'userRole.Merchant': 'تاجر',
          'userRole.DeliveryAgent': 'مندوب توصيل',
          'RequestStatus.Request' : 'جارى الطلب' ,

           'RequestStatus.Accept' : 'طلب مقبول',

            'RequestStatus.Refuse' : 'طلب مرفوض'
        }
      };
}
