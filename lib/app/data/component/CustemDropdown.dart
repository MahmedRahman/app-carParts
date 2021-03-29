import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:flutter/material.dart';

class CustemDropdown extends StatelessWidget {
  const CustemDropdown({
    @required this.dataList,
  });

  final List<String> dataList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: DropdownButtonFormField(
          isDense: false,
          decoration: InputDecoration.collapsed(hintText: ''),
          dropdownColor: Colors.white,
          value: 0,
          elevation: 2,
          isExpanded: true,
          icon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Icon(Icons.arrow_downward,color: KAccentColor,),
          ),
          iconDisabledColor: KAccentColor,
          items: List.generate(dataList.length, (index) {
            return DropdownMenuItem(
              value: index,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  dataList.elementAt(index),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            print(value);
          },
        ),
      ),
    );
  }
}
