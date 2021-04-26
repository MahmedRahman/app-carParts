import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CustemButtonTest extends StatelessWidget {
   final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

   CustemButtonTest({
    @required this.title,
    this.backgroundColor = KAccentColor,
    this.buttonIcons = Icons.arrow_back_ios,
    @required this.onPressed,
  });
//   this.buttonController
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
        child: RoundedLoadingButton(
          color: backgroundColor,
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          controller: _btnController,
          onPressed: () async {
            try {
              FocusScope.of(context).unfocus();

              await onPressed();

              if (GetUtils.isNullOrBlank(_btnController)) {
                _btnController.reset();
              }
            } on Exception catch (_) {
              _btnController.reset();
            }
          },
        ),
      ),
    );
  }
}
