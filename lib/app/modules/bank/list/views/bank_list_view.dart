import 'package:carpart/app/data/component/CustomIndicator.dart';
import 'package:carpart/app/data/model/bank_model.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bank_list_controller.dart';

class BankListView extends GetView<BankListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حساباتى البنكية'),
        centerTitle: true,
           actions: [
          IconButton(icon: Icon(Icons.add), onPressed: (){  Get.offNamed(Routes.BANK_ADD);})
        ],
      ),
    
      body: FutureBuilder(
          future: controller.getUserBank(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<BankModel> bankModel = snapshot.data;

              return Column(
                children: List.generate(bankModel.length, (index) {
                  BankModel bankItem = bankModel.elementAt(index);
                  return Card(
                    child: ListTile(
                      title: Text(bankItem.bankName),
                      subtitle: Text(bankItem.iban.toString()),
                      leading: Icon(Icons.payment),
                      
                    ),
                  );
                }).toList(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: CustomIndicator(
                  indicatorStatus:IndicatorStatus.error ,
                ),
              );
            }
            return Center(child: CustomIndicator());
          }),
    );
  }
}
