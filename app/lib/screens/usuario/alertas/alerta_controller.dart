import 'package:app/helpers/api.dart';
import 'package:app/helpers/data.dart';
import 'package:app/models/alerta.dart';
import 'package:app/models/usuario.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AlertaController extends GetxController {
  Usuario? usuario;
  @override
  void onInit() async {
    usuario = Datos().recoveryData();
    await obtenerMisAlertas();
    super.onInit();
  }

  List<Alerta> alertas = [];
  RxString message = ''.obs;
  Future obtenerMisAlertas() async {
    try {
      ApiService apiService = ApiService();

      Map<String, dynamic> body = {"usuario": usuario!.sId};

      final respuesta = await apiService.fetchData('alerta/usuario',
          method: Method.POST, body: body);

      if (apiService.status == 200) {
        alertas = Alerta.fromJsonList(respuesta);
        message.value = '';
      } else {
        message.value = respuesta['message'];
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  String estado(estatus) {
    String letra = '';
    switch (estatus) {
      case 'Activo':
        letra = 'A';
        break;
      case 'Inactivo':
        letra = 'I';
        break;
      case 'Pendiente':
        letra = 'P';
        break;
      case 'Seleccionado':
        letra = 'S';
        break;
    }

    return letra;
  }
}
