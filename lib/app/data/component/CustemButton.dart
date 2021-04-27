import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustemButton extends StatelessWidget {
  // final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  const CustemButton(
      {@required this.title,
      this.backgroundColor = KAccentColor,
      this.buttonIcons = Icons.arrow_back_ios,
      this.onPressed});

  final String title;
  final Color backgroundColor;
  final IconData buttonIcons;
  final Function onPressed;
 

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        child: SizedBox(
          width: Get.width*.9,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: backgroundColor,
              
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              onPressed();
            },
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
