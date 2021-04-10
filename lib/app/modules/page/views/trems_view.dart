import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class TremsView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TremsView'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: pageTream,
          builder: (context, snapshot) {
            return Html(data: snapshot.data);
          }),
    );
  }
}
