import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomIndicator extends StatelessWidget {
  CustomIndicator({this.indicatorStatus = IndicatorStatus.wait});

  IndicatorStatus indicatorStatus;
  @override
  Widget build(BuildContext context) {
    switch (indicatorStatus) {
      case IndicatorStatus.wait:
        return CircularProgressIndicator();
        break;

      case IndicatorStatus.error:
         return Lottie.asset('images/error.json');
        break;

      case IndicatorStatus.imageplaceholder:
        return CircularProgressIndicator();
        break;



      default:
        return CircularProgressIndicator();
    }
  }
}

enum IndicatorStatus {
  wait,
  error,
  imageplaceholder,
  ListProduct,
  NoProductFound,
}
