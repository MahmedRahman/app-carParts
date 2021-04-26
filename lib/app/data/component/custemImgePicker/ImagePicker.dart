import 'dart:io';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PickYouImage {
  var selectImagePath;
  var selectImageSize;
  var cropperImagePath;
  var cropperImageSize;
  String imageBytes;

  Future getImage({@required ImageSource source}) async {
    final pickedFile = await ImagePicker().getImage(source: source);

    if (pickedFile != null) {
      selectImagePath = '';
      selectImageSize = '';

      selectImagePath = pickedFile.path.toString();
      selectImageSize = ((File(pickedFile.path).lengthSync() / 1024 / 1024)
              .toStringAsFixed(2)) +
          ' MB';

//corp corp corp corp corp corp corp corp corp

      final corpImageFile = await ImageCropper.cropImage(
          sourcePath: selectImagePath,
          maxWidth: 512,
          maxHeight: 512,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100);
      cropperImagePath = corpImageFile.path;
      cropperImageSize = ((File(cropperImagePath).lengthSync() / 1024 / 1024)
              .toStringAsFixed(2)) +
          ' MB';

      print("Origin Size : " + selectImageSize);
      print("cropper Size : " + cropperImageSize);

      return await File(cropperImagePath).readAsBytes().then((value) {
        return value.toString();
      }, onError: (err) {
        return Future.error('error');
      });
    } else {

      print('لم يتم اختيار صورة');
      /*
      showSnackBar(
        title: AppName,
        message: 'لم يتم اختيار صورة',
        snackbarStatus: () {},
      );*/
    }
  }
}
