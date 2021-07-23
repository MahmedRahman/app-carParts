import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/modules/order/detail/controllers/order_detail_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PayView extends GetView<OrderDetailController> {
  @override
  Widget build(BuildContext context) {
    OrderDetailController controller = Get.put(OrderDetailController());

    var Brand = "VISA".obs;
    var Expiry_Month = '01'.obs;
    var Expiry_Year = '2021'.obs;

    TextEditingController CardNumber = new TextEditingController();
    TextEditingController CardHolder = new TextEditingController();
    TextEditingController ExpiryMonth = new TextEditingController();
    TextEditingController ExpiryYear = new TextEditingController();
    TextEditingController CVV = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('دفع'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Column(
         
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'بيانات الدفع',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() {
                return Container(
                  width: Get.width,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: DropdownButton(
                      isExpanded: true,
                      value: Brand.value,
                      items: [
                        DropdownMenuItem(
                          child: Text("VISA"),
                          value: 'VISA',
                        ),
                        DropdownMenuItem(
                          child: Text("MASTER"),
                          value: 'MASTER',
                        ),
                        DropdownMenuItem(
                          child: Text("MADA"),
                          value: 'MADA',
                        )
                      ],
                      onChanged: (String value) {
                        Brand.value = value;
                      },
                      hint: Text("Select item"),
                    ),
                  ),
                );
              }),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: CardHolder,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Card holder name',
                  helperText: 'Card holder name',
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: CardNumber,
                keyboardType: TextInputType.number,
                maxLength: 16,
                decoration: InputDecoration(
                  hintText: 'Card number',
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Expiry Month'),
              SizedBox(
                height: 10,
              ),
              Obx(() {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: Expiry_Month.value,
                      items: <String>[
                        '01',
                        '02',
                        '03',
                        '04',
                        '05',
                        '06',
                        '07',
                        '08',
                        '09',
                        '10',
                        '11',
                        '12'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        Expiry_Month.value = value;

                        ExpiryMonth.text = value;
                      },
                    ),
                  ),
                );
              }),
              SizedBox(
                height: 10,
              ),
           
           Text('Expiry Year'),
              SizedBox(
                height: 10,
              ), 
           
              Obx(() {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text('data'),
                      value: Expiry_Year.value,
                      items: <String>[
                        '2021',
                        '2022',
                        '2023',
                        '2024',
                        '2025',
                        '2026',
                        '2027',
                        '2028',
                        '2029',
                        '2030'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        Expiry_Year.value = value;

                        ExpiryYear.text = value;
                      },
                    ),
                  ),
                );
              }),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: CVV,
                keyboardType: TextInputType.number,
                maxLength: 3,
                decoration: InputDecoration(
                  hintText: 'CVV',
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustemButton(
                title: 'دفع',
                onPressed: () {
                  controller.addPaymentCard(
                    Brand: Brand.value,
                    CVV: CVV.text,
                    CardHolder: CardHolder.text,
                    CardNumber: CardNumber.text,
                    ExpiryMonth: ExpiryMonth.text,
                    ExpiryYear: ExpiryYear.text,
                  );
                  //Get.back();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
