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
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Get.offNamed(Routes.PAYMENT_ADD);
              }),
        ],
      ),
      body: FutureBuilder(
          future: controller.getPaymentRequest(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<PaymentModel> Listpayment = snapshot.data;
              // Listpayment.sort();
              return Column(
                  children: List.generate(Listpayment.length, (index) {
                PaymentModel payment = Listpayment.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    child: ListTile(
                      title: Text(payment.price.toStringAsFixed(0)),
                      subtitle: Text(
                        RequestStatus.values[payment.status].toString().tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(DateFormat.MMMd().format(payment.date)),
                      leading: Icon(Icons.money),
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
