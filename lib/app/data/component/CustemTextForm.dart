import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:flutter/material.dart';

class CustemTextForm extends StatelessWidget {
  const CustemTextForm(
      {@required this.textHint,
      this.textIconData,
      this.textmaxLines = 1,
      this.inputcontroller,
      this.textInputType,
      this.onValidator});

  final String textHint;
  final IconData textIconData;
  final int textmaxLines;
  final TextEditingController inputcontroller;
  final TextInputType textInputType;
  final FormFieldSetter<String> onValidator;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.15),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: TextFormField(
        keyboardType: textInputType ?? TextInputType.multiline,
        controller: inputcontroller,
        maxLines: textmaxLines, // when user presses enter it will adapt to it
        validator: onValidator,
        decoration: InputDecoration(
          suffixIcon: Icon(textIconData),
          filled: true,
          fillColor: Colors.white,
          hintText: textHint,
          labelStyle: TextStyle(
            color: KScandaryColor,
          ),
          focusColor: Colors.red,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
