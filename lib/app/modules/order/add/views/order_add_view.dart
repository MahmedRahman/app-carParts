import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/data/component/CustemButton.dart';
import 'package:carpart/app/data/component/CustemTextForm.dart';
import 'package:carpart/app/data/component/CustomImageCached.dart';

import 'package:carpart/app/data/component/MapSample.dart';
import 'package:carpart/app/data/component/custemImgePicker/CustemImagePicker.dart';
import 'package:carpart/app/data/helper/AppConstant.dart';
import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:carpart/app/data/helper/AppTheme.dart';
import 'package:carpart/app/data/helper/AppValidation.dart';
import 'package:carpart/app/data/helper/showSnackBar.dart';
import 'package:carpart/app/modules/home/views/home_view.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/order_add_controller.dart';

class OrderAddView extends GetView<OrderAddController> {
  var modelsList = [].obs;
  var modelsSelectIndex = 0.obs;
  var markSelectIndex = 0.obs;

  @override
  Widget build(BuildContext context) {

/*
  if (GetUtils.isNullOrBlank(Get.find<UserAuth>().getUserToken())) {
        KRole = userRole.anonymous;
      } else {
        //getProfile();
         //KRole = userRole.;

          KRole = userRole.DeliveryAgent;
      }
*/

    Get.lazyPut<OrderAddController>(
      () => OrderAddController(),
    );
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: Get.width * .2,
          child: Image.asset(
            'images/logodark.png',
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: KPrimaryColor,
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'images/bg_home.png',
              ),
            ),
          ),
          child: ListView(
            children: [
              SizedBox(
                height: Get.height * .3,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  children:List.generate(KSlider.length, (index) => Center(
                      child: CustomImageCached(imageUrl: "https://carpart.atpnet.net/Files/Setting/${KSlider.elementAt(index)['Image']}",),
                    )) 
                  
                  
                  
                  ,
                ),
              ),
              (KRole == userRole.anonymous || KRole == userRole.Client)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '??????',
                                  style: headline1.copyWith(
                                    color: KScandaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '??',
                                  style: headline1.copyWith(
                                    color: KAccentColor,
                                  ),
                                ),
                              ],
                            ),
                            Obx(() {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.15),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      )
                                    ],
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      items: Cars.map(
                                        (e) {
                                          return new DropdownMenuItem(
                                            child: new Text(e.name.toString()),
                                            value: e.id,
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (value) {
                                        controller.carMarkid = value;
                                        controller.carModelId = 0;
                                        markSelectIndex.value = value;
                                        modelsSelectIndex.value = 0;
                                        modelsList.clear();
                                        modelsList.addAll(
                                            Cars.elementAt(value - 1).models);
                                      },
                                      hint: Text('???????????? ?????????? ??????????????'),
                                      value: markSelectIndex.value == 0
                                          ? null
                                          : markSelectIndex.value,
                                    ),
                                  ),
                                ),
                              );
                            }),
                            Obx(() {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.15),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      )
                                    ],
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      items: modelsList.map(
                                        (e) {
                                          return new DropdownMenuItem(
                                            child: new Text(e.name.toString()),
                                            value: e.id,
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (value) {
                                        controller.carModelId = value;
                                        modelsSelectIndex.value = value;
                                      },
                                      hint: Text('???????????? ?????? ??????????????'),
                                      value: modelsSelectIndex.value == 0
                                          ? null
                                          : modelsSelectIndex.value,
                                    ),
                                  ),
                                ),
                              );
                            }),
                            SizedBox(
                              height: 10,
                            ),
                            /* Obx(() {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.15),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      )
                                    ],
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      items: verisionYears.map(
                                        (e) {
                                          return new DropdownMenuItem(
                                            child: new Text(e.toString()),
                                            value: e,
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (value) {
                                        controller.versionYear.value =
                                            value.toString();
                                        print(value);
                                      },
                                      hint: Text('???????????? ?????? ?????? ??????????????'),
                                      value: controller.versionYear.value == ''
                                          ? null
                                          : controller.versionYear.value,
                                    ),
                                  ),
                                ),
                              );
                            }),*/
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                  validator: (value) {
                                    return AppValidation.checkEmpty(value);
                                  },
                                  readOnly: true,
                                  style: TextStyle(fontSize: 16),
                                  controller: controller.versionYearController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: '???????????? ?????? ?????? ??????????????',
                                    border: InputBorder.none,
                                    suffixIcon: Icon(
                                      Icons.calendar_today,
                                    ),
                                  ),
                                  onTap: () =>
                                      handleReadOnlyInputClick(context),
                                ),
                              ),
                            ),

                            /*CustemTextForm(
                              textHint: '?????? ??????????',
                              inputcontroller: controller.versionYear,
                              textInputType: TextInputType.number,
                              onValidator: (value) {
                                return AppValidation.checkEmpty(value);
                              },
                            ),*/
                            SizedBox(
                              height: 10,
                            ),
                            CustemTextForm(
                              textHint: '?????? ????????????',
                              inputcontroller: controller.vanNumber,
                              textInputType: TextInputType.number,
                              onValidator: (value) {
                                return AppValidation.checkEmpty(value);
                              },
                            ),
                            CustemTextForm(
                              textmaxLines: 5,
                              textHint: '???????? ????????',
                              inputcontroller: controller.description,
                              onValidator: (value) {
                                return AppValidation.checkEmpty(value);
                              },
                            ),
                            CustemImagePicker(
                              onclick: (value) {
                                controller.carImageBytes = value;
                              },
                            ),
                            CustemButton(
                              title: '??????????',
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  markSelectIndex.value = 0;
                                  modelsSelectIndex.value = 0;
                                  controller.createorder();
                                }
                              },
                            ),
                            /*
                            CustemButtonTest(
                              onPressedbnt: (callback) async {
                               await Future.delayed(Duration(seconds: 2), () {
                                  print('x1');
                                  print('x2');
                                });
                              callback();
                              },
                              child: Text('hi'),
                            )*/
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 250,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Text(
                            '?????????? ?????????????? ???????????? ???????????? ???? ?????????? ?????? ????????',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void handleReadOnlyInputClick(context) {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        child: YearPicker(
          selectedDate: DateTime(1997),
          firstDate: DateTime(1995),
          lastDate: DateTime.now(),
          onChanged: (val) {
            controller.versionYearController.text = val.year.toString();
            print(val);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
