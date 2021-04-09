import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CustemButton extends StatelessWidget {
 // final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  const CustemButton(
      {@required this.title,
      this.backgroundColor = KAccentColor,
      this.buttonIcons = Icons.arrow_back_ios,
      this.onPressed,
      this.buttonController});

  final String title;
  final Color backgroundColor;
  final IconData buttonIcons;
  final Function onPressed;
  final RoundedLoadingButtonController buttonController;

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
          child: RoundedLoadingButton(
            
            color: backgroundColor,
            
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            controller: buttonController,
            onPressed: () {
              FocusScope.of(context).unfocus();
              onPressed();
            },
          )),
    );
  }
}
