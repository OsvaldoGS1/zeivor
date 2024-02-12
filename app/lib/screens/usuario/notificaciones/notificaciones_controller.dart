import 'package:app/helpers/api.dart';
import 'package:app/helpers/data.dart';
import 'package:app/helpers/formatos.dart';
import 'package:app/helpers/obtener_oficio.dart';
import 'package:app/helpers/position.dart';
import 'package:app/models/oferta.dart';
import 'package:app/models/oficio.dart';
import 'package:app/models/usuario.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class NotificacionesController extends GetxController {
  Usuario? usuario;
  Position? ps; // Get.arguments;
  Oficio? oficio;

  @override
  void onInit() async {
    usuario = Datos().recoveryData();
    oficio = await DatosOficio().datosOficio(usuario!);
    Posicion posicion = Get.find();
    ps = posicion.lugar;
    await obtenerOfertas();
    super.onInit();
  }

  RxBool isloading = false.obs;
  List<Oferta> ofertas = [];
  RxString mensaje = ''.obs;

  Future obtenerOfertas() async {
    isloading.value = true;
    // ps = await Posicion().obtener();
    try {
      ApiService apiService = ApiService();
      Map<String, dynamic> body = {"profesionista": oficio!.idOficio};
      final respuesta = await apiService.fetchData('contacto/consultar',
          method: Method.POST, body: body);
      if (apiService.status == 200) {
        mensaje.value = '';
        ofertas = Oferta.fromJsonList(respuesta);
      } else {
        mensaje = respuesta['message'];
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error al obtener ofertas:");
      }
    }
    isloading.value = false;
  }

  String distancia(String coordenadas) {
    String coordenadas2 = '${ps!.latitude},${ps!.longitude}';
    return Formato().obtenerDistancia(coordenadas, coordenadas2);
  }
}
