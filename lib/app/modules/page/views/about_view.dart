import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class AboutView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عن المشروع'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'عن المشروع', 
          style: TextStyle(fontSize:20),
        ),
      ),
    );
  }
}
  