import 'dart:io';

import 'package:carpart/app/data/component/CustomImageCached.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'ImagePicker.dart';

class CustemImagePicker extends StatelessWidget {
  CustemImagePicker({
    this.onclick,
    this.title,
    this.showimagepath,
  });

  Function onclick;
  String title;
  String showimagepath;

  var imagepath = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black.withOpacity(.3))),
        child: Column(
          children: [
            Obx(() {
              return GetUtils.isNullOrBlank(imagepath.value)
                  ?  GetUtils.isNullOrBlank(showimagepath) ? Container() : CustomImageCached(
                    imageUrl: showimagepath,
                  )
                  : Image.file(
                      File(imagepath.value),
                    );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: title == null ? Text('ارفق صورة') : Text(title),
                ),
                IconButton(
                  icon: Icon(Icons.file_upload),
                  onPressed: () {
                    PickYouImage pickYouImage = new PickYouImage();
                    pickYouImage.getImage(source: ImageSource.gallery).then(
                      (value) {
                        imagepath.value = pickYouImage.selectImagePath;
                        onclick(value);
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt_sharp),
                  onPressed: () {
                    PickYouImage pickYouImage = new PickYouImage();
                    pickYouImage.getImage(source: ImageSource.camera).then(
                      (value) {
                        imagepath.value = pickYouImage.selectImagePath;
                        onclick(value);
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
