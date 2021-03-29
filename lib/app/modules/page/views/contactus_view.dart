import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class ContactusView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('أتصل بنا'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'أتصل بنا', 
          style: TextStyle(fontSize:20),
        ),
      ),
    );
  }
}
  