import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/modules/authiocation/views/splash_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../controllers/entry_point_controller.dart';

class EntryPointView extends GetView<EntryPointController> {
  @override
  Widget build(BuildContext context) {
    EntryPointController entryPointController = Get.put(EntryPointController());
    entryPointController.start();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
          color: KScandaryColor,
        ),
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // Get.offNamed(Routes.HOME);
              },
              child: Container(
                height: Get.height,
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Get.width * .4,
                      child: Image.asset(
                        'images/logolight.png',
                      ),
                    ),
                    SizedBox(
                      width: Get.width * .3,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulse,
                        
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 1,
              left: 1,
              right: 1,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      '?????????? ????????',
                      style: headline3.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '?????????? ?????? ?????????????? ????????????',
                      style: headline4.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
