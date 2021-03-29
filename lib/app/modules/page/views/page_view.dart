import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class PageView extends GetView<PageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PageView is working', 
          style: TextStyle(fontSize:20),
        ),
      ),
    );
  }
}
  