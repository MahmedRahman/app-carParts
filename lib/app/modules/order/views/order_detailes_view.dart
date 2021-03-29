import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailesView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('طلب رقم : 563453131'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              width: Get.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'رقم الطلب : 54513134',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'تاريخ الطلب : 21/2/2021',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'سيارة تويوتا',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'كامري',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'موديل : 2020',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'رقم الهيكل :  521454512101',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'وصف الطلب',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'مطلوب قماش فرامل امامي يمين',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: Get.width,
              constraints: BoxConstraints(minHeight: 150),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
              child: Center(
                child: Text(
                  'لا توجد عروض حتى الان من التاجر',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: Get.width,
              constraints: BoxConstraints(minHeight: 150),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'اسم التاجر',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text('الشماسي لقطع الغير'),
                  ),
                  ListTile(
                    title: Text(
                      'عنوان التاجر',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text('الصناعية، شارع،47323'),
                  ),
                  ListTile(
                      title: Text(
                        'وكالة',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('500'),
                      trailing: ElevatedButton(
                        child: Text('قبول'),
                        onPressed: () {},
                      )),
                  ListTile(
                      title: Text(
                        'ايسيديلكو',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('500'),
                      trailing: ElevatedButton(
                        child: Text('قبول'),
                        onPressed: () {},
                      )),
                  ListTile(
                      title: Text(
                        'امريكي',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('500'),
                      trailing: ElevatedButton(
                        child: Text('قبول'),
                        onPressed: () {},
                      )),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: Get.width,
              constraints: BoxConstraints(minHeight: 150),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                    )
                  ]),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'اسم التاجر',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text('الشماسي لقطع الغير'),
                  ),
                  ListTile(
                    title: Text(
                      'عنوان التاجر',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text('الشماسي لقطع الغير'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
