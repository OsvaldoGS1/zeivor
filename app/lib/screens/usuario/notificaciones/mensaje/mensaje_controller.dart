import 'package:app/helpers/api.dart';
import 'package:app/helpers/data.dart';
import 'package:app/helpers/formatos.dart';
import 'package:app/models/oferta.dart';
import 'package:app/models/usuario.dart';
import 'package:app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MensajeController extends GetxController {
  Oferta oferta = Get.arguments[0];
  Position ps = Get.arguments[1];

  Usuario? usuario;
  @override
  void onInit() {
    usuario = Datos().recoveryData();
    super.onInit();
  }

  String distancia(String coordenadas) {
    String coordenadas2 = '${ps.latitude},${ps.longitude}';
    return Formato().obtenerDistancia(coordenadas, coordenadas2);
  }

  RxString message = ''.obs;
  Future aceptarOferta() async {
    try {
      ApiService apiService = ApiService();
      Map<String, dynamic> body = {"oferta": oferta.idContacto};

      final respuesta = await apiService.fetchData('contacto/aceptar',
          method: Method.POST, body: body);
      if (apiService.status == 200) {
        await Get.toNamed(Routes.ubicacion, arguments: oferta);
      } else {
        message.value = respuesta['message'];
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
}
