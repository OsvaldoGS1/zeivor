import 'package:app/helpers/api.dart';
import 'package:app/helpers/data.dart';
import 'package:app/helpers/obtener_oficio.dart';
import 'package:app/models/alerta_oficio.dart';
import 'package:app/models/cliente.dart';
import 'package:app/models/oficio.dart';
import 'package:app/models/usuario.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AlertasOficioController extends GetxController {
  Usuario? usuario;
  @override
  void onInit() async {
    // TODO: implement onInit
    usuario = Datos().recoveryData();
    // await obtenerAlertas();
    super.onInit();
  }

  List<AlertaOficio> alertas = [];

  Cliente? cliente;
  RxString message = ''.obs;

  // Future obtenerAlertas() async {
  //   try {
  //     cliente = await DatosCliente().datosOficio(usuario!);
  //     ApiService apiService = ApiService();
  //     Map<String, dynamic> body = {"oficio": cliente!.idOficio};
  //     final respuesta = await apiService.fetchData('alerta/oficio',
  //         method: Method.POST, body: body);

  //     if (apiService.status == 200) {
  //       alertas = AlertaOficio.fromJsonList(respuesta);
  //       message.value = '';
  //     } else {
  //       message.value = respuesta;
  //     }
  //   } catch (error) {
  //     if (kDebugMode) {
  //       print(error);
  //     }
  //   }
  // }

  // Future aceptarAlerta(AlertaOficio alerta) async {
  //   try {
  //     oficio = await DatosOficio().datosOficio(usuario!);
  //     ApiService apiService = ApiService();
  //     Map<String, dynamic> body = {
  //       "alerta": alerta.idAlerta,
  //       "oficio": oficio!.idOficio
  //     };
  //     final respuesta = await apiService.fetchData('alerta/aceptar',
  //         method: Method.POST, body: body);

  //     if (apiService.status == 200) {
  //       Get.back();
  //       Get.back();
  //       snackbar(respuesta['message'], '');
  //       // message.value = '';
  //     } else {
  //       snackbar('Error', respuesta['message']);

  //       // message.value = respuesta;
  //     }
  //   } catch (error) {
  //     if (kDebugMode) {
  //       print(error);
  //     }
  //   }
  // }
}
