import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:flutter_html/flutter_html.dart';

class AboutView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عن المشروع'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: pageAbout,
        builder: (context, snapshot) {
          return Html(
            data:snapshot.data
          );
        }
      )
    );
  }
}

