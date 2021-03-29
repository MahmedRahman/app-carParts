import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class TremsView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TremsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TremsView is working', 
          style: TextStyle(fontSize:20),
        ),
      ),
    );
  }
}
  