import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdownButton extends StatelessWidget {
  CustomDropdownButton(
     {
    @required this.listDropdown,
     @required  this.listDropdownValue,
    this.labelDropdownButton,
    this.onChanged,
    this.labelhint,
    this.showlabel = false, @required this.selectText,
  });

  final List<String> listDropdown;
  final List<int> listDropdownValue;
  final String labelDropdownButton;
  final String labelhint;
  final Function onChanged;
  final bool showlabel;
  var selectText;
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: labelDropdownButton.isEmpty ? 0 : null,
            child: Align(
                alignment: Alignment.centerRight,
                child: showlabel
                    ? Text(
                        labelDropdownButton,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      )
                    : SizedBox.shrink()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Color(0XFF707070),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Obx(() {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButton(
                    hint: Text(labelhint ?? labelDropdownButton),
                    value: selectText.value == '-1' ? null : selectText.value,
                    isDense: false,
                    elevation: 2,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    items: new List.generate(
                      listDropdown.length,
                      (index) {
                        return new DropdownMenuItem(
                          value: listDropdownValue.elementAt(index).toString(),
                          child: Text(
                            listDropdown.elementAt(index).toString(),
                          ),
                        );
                      },
                    ),
                    onChanged: (value) {
            print(value);
                      selectText.value = value;
              
                      onChanged(value);
                    },
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
