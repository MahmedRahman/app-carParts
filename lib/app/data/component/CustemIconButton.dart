
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:flutter/material.dart';

class CustemIconButton extends StatelessWidget {
  const CustemIconButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: KAccentColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ]),
      child: IconButton(
        color: KPrimaryColor,
        constraints: BoxConstraints(
          minWidth: 128,
          minHeight: 128,
        ),
        onPressed: () {},
        icon: Icon(Icons.camera_alt_outlined),
        //label: SizedBox.shrink(),
      ),
    );
  }
}
