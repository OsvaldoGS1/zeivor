import 'package:app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';

class PermisoUbicacionController extends GetxController {
// final MyRepository repository;
// PermisoUbicacionController(this.repository);

//   final _obj = ''.obs;
//   set obj(value) => this._obj.value = value;
//   get obj => this._obj.value;

  Future openLocationSettings() async {
    try {
      bool activado = await Geolocator.openLocationSettings();
      if (activado) {
        LocationPermission permiso = (await Geolocator.checkPermission());
        if (permiso == LocationPermission.always ||
            permiso == LocationPermission.whileInUse) {
          await Get.offAllNamed(Routes.home);
        }
      } else {
        print('Error al activar los servicios de ubicacion');
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
}
