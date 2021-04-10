import 'package:carpart/app/modules/authiocation/views/splash_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/entry_point_controller.dart';

class EntryPointView extends GetView<EntryPointController> {
  @override
  Widget build(BuildContext context) {
    EntryPointController entryPointController = Get.put(EntryPointController());
    entryPointController.Start();
    return SplashView();
  }
}
