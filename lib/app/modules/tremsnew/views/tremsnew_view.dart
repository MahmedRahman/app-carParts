import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';

import '../controllers/tremsnew_controller.dart';

class TremsnewView extends GetView<TremsnewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الشروط و الاحكام'),
        centerTitle: true,
      ),
      body:FutureBuilder(
        future: pageTream,
        builder: (context, snapshot) {
          return Html(
            data: KTerms.value
          );
        }
      ),
    );
  }
}
