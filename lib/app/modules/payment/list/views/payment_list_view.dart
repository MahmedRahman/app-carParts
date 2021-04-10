import 'package:carpart/app/data/component/CustomIndicator.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/model/payment_model.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/payment_list_controller.dart';

class PaymentListView extends GetView<PaymentListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('طلبات التحويل'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.offNamed(Routes.PAYMENT_ADD);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
          future: controller.getPaymentRequest(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<PaymentModel> Listpayment = snapshot.data;
              Listpayment.sort();
              return Column(
                  children: List.generate(Listpayment.length, (index) {
                PaymentModel payment = Listpayment.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    child: ListTile(
                      trailing: Text(payment.price.toStringAsFixed(0)),
                      title: Text(DateFormat.MMMd().format(payment.date)),
                      subtitle: Text(payment.status.toString()),
                      leading: Text(RequestStatus.values[payment.id].toString().tr ,style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                );
              }).toList());
            } else if (snapshot.hasError) {
              return Center(
                child: CustomIndicator(
                  indicatorStatus: IndicatorStatus.error,
                ),
              );
            }
            return Center(child: CustomIndicator());
          }),
    );
  }
}
