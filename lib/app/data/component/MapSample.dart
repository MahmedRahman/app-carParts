import 'package:carpart/app/data/helper/AppEnumeration.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  GoogleMapController _controller;
  var allMarker = List<Marker>().obs;

  @override
  Widget build(BuildContext context) {
    allMarker.add(
      Marker(
        markerId: MarkerId('MarkerId'),
        draggable: true,
        position: LatLng(Klatitude, Klongitude),
      ),
    );
    return new Scaffold(
      /*appBar: AppBar(
        title: Text('تحديد العنوان'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
      */
      body: Obx(() {
        return GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
            target: LatLng(Klatitude, Klongitude),
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          onTap: (LatLng _latLng) {
            Marker marker = Marker(
              markerId: MarkerId('MarkerId'),
              draggable: true,
              position: _latLng,
            );
            Klatitude = _latLng.latitude;
            Klongitude = _latLng.longitude;
            allMarker.add(marker);
          },
          markers: Set.from(allMarker),
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.location_pin,
          color: Colors.white,
        ),
        onPressed: () {
          Geolocator.getCurrentPosition().then(
            (_latLng) {
              _controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(
                        _latLng.latitude,
                        _latLng.longitude,
                      ),
                      zoom: 14.0,
                      bearing: 45.0,
                      tilt: 45.0),
                ),
              );

              Marker marker = Marker(
                markerId: MarkerId('MarkerId'),
                draggable: true,
                position: LatLng(
                  _latLng.latitude,
                  _latLng.longitude,
                ),
              );
              Klatitude = _latLng.latitude;
              Klongitude = _latLng.longitude;
              allMarker.add(marker);
            },
          );
        },
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  GoogleMapController _controller;
  var allMarker = List<Marker>().obs;

  @override
  Widget build(BuildContext context) {
    allMarker.add(
      Marker(
        markerId: MarkerId('MarkerId'),
        draggable: true,
        position: LatLng(Klatitude, Klongitude),
      ),
    );
    return new Scaffold(
      appBar: AppBar(
        title: Text('تحديد العنوان'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
      body: Obx(() {
        return Column(
          children: [
/*
            TextField(
            //  controller: _controller,
             
              onTap: () async {
        
              },
              decoration: InputDecoration(
                icon: Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 10,
                  height: 10,
                  child: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                ),
                hintText: "Enter your shipping address",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
              ),
            ),*/
            Expanded(
              child: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                  target: LatLng(Klatitude, Klongitude),
                  zoom: 14.4746,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
                onTap: (LatLng _latLng) {
                  Marker marker = Marker(
                    markerId: MarkerId('MarkerId'),
                    draggable: true,
                    position: _latLng,
                  );
                  Klatitude = _latLng.latitude;
                  Klongitude = _latLng.longitude;
                  allMarker.add(marker);
                },
                markers: Set.from(allMarker),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.location_pin,
          color: Colors.white,
        ),
        onPressed: () {
          Geolocator.getCurrentPosition().then(
            (_latLng) {
              _controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(
                        _latLng.latitude,
                        _latLng.longitude,
                      ),
                      zoom: 14.0,
                      bearing: 45.0,
                      tilt: 45.0),
                ),
              );

              Marker marker = Marker(
                markerId: MarkerId('MarkerId'),
                draggable: true,
                position: LatLng(
                  _latLng.latitude,
                  _latLng.longitude,
                ),
              );
              Klatitude = _latLng.latitude;
              Klongitude = _latLng.longitude;
              allMarker.add(marker);
            },
          );
        },
      ),
    );
  }
}
