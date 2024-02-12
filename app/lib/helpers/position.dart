import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class Posicion extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await obtenerPosicion();
    // permiso.value = await obtenerPermiso();
  }

  Position? lugar;
  // RxBool permiso = false.obs;

  Future<Position?> obtenerPosicion() async {
    Position? posicionActual;

    bool permiso = await obtenerPermiso();
    if (permiso) {
      posicionActual = await Geolocator.getCurrentPosition();
    } else {
      posicionActual = await Geolocator.getLastKnownPosition();
    }
    lugar = posicionActual;
    return posicionActual;
  }

  Future<bool> obtenerPermiso() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
    } else {
      return true;
    }
  }
}
