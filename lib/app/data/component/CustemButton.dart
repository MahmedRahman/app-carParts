import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:flutter/material.dart';

class CustemButton extends StatelessWidget {
  const CustemButton({
    @required this.title,
    this.backgroundColor = KAccentColor,
    this.buttonIcons = Icons.arrow_back_ios,
    this.onPressed, 
  });

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
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  buttonIcons,
                  color: backgroundColor,
                  size: 15,
                ),
              ),
            ),
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            onPressed();
          },
          label: Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
