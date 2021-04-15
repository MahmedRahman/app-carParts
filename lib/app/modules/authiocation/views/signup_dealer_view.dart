import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/component/custemImgePicker/CustemImagePicker.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppUtils.dart';
import 'package:carpart/app/modules/authiocation/controllers/authiocation_controller.dart';
import 'package:carpart/app/modules/authiocation/views/signin_view.dart';
import 'package:carpart/app/modules/order/views/order_create_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SignupDealerView extends GetView<AuthiocationController> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              AuthiocationHeader(
                title: 'حياك معنا',
              ),
              CustemTextForm(
                textHint: 'اسم النشاط التجاري',
                inputcontroller: controller.businessName,
              ),
              CustemImagePicker(
                onclick: (value) {
                  controller.registrationImageBytes = value;
                },
              ),
              InkWell(
                onTap: () {
                  Get.to(MapSample(), fullscreenDialog: true);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    color: Colors.grey,
                    child: Stack(
                      children: [
                        GoogleMap(
                          mapType: MapType.hybrid,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(Klatitude, Klongitude),
                            zoom: 14.4746,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.grey.withOpacity(.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CustemButton(
                title: 'تسجيل',
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    controller.upgrateMerchant();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
