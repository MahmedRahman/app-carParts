import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:carpart/app/modules/authiocation/controllers/authiocation_controller.dart';

class AuthiocationView extends GetView<AuthiocationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AuthiocationView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AuthiocationView is working', 
          style: TextStyle(fontSize:20),
        ),
      ),
    );
  }
}
  