import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'ImagePicker.dart';

class CustemImagePicker extends StatefulWidget {
  CustemImagePicker({this.onclick, this.title});

  Function onclick;
  String title;

  @override
  _custemImagePicker createState() => _custemImagePicker();
}

class _custemImagePicker extends State<CustemImagePicker> {
  PickYouImage pickYouImage = new PickYouImage();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            pickYouImage.selectImagePath != null
                ? Image.file(File(pickYouImage.selectImagePath))
                : SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: widget.title == null
                      ? Text('ارفق صورة')
                      : Text(widget.title),
                ),
                IconButton(
                  icon: Icon(Icons.file_upload),
                  onPressed: () {
                    pickYouImage.getImage(source: ImageSource.gallery).then(
                      (value) {
                        setState(() {});
                        widget.onclick(value);
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt_sharp),
                  onPressed: () {
                    pickYouImage.getImage(source: ImageSource.camera).then(
                      (value) {
                        setState(() {});
                        widget.onclick(value);
                      },
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
