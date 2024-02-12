import 'package:app/helpers/api.dart';
import 'package:app/helpers/data.dart';
import 'package:app/models/favorito.dart';
import 'package:app/models/opiniones_trabajador.dart';
import 'package:app/models/profesionista_disponibles.dart';
import 'package:app/models/usuario.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/screens/home/home_controller.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetallesController extends GetxController {
  Rx<Favorito> oficio = Favorito().obs;
  Rx<ProfesionistasDisponibles> profesion = ProfesionistasDisponibles().obs;
  RxString tipo = ''.obs;
  RxString tarjeta = ''.obs;
  RxString transferencia = ''.obs;
  RxString efectivo = ''.obs;
  RxBool isActivo = false.obs;
  Usuario? usuario;

  @override
  void onInit() {
    usuario = Datos().recoveryData();
    tipo.value = Get.arguments[0];
    List pagos = [];
    if (tipo.value == 'favorito') {
      oficio.value = Get.arguments[1];
      pagos = oficio.value.metodosPago!.split(',');
    } else {
      profesion.value = Get.arguments[1];
      pagos = profesion.value.metodosPago!.split(',');
    }
    isActivo.value = verEstatus();
    // oficio.value = Get.arguments;
    if (pagos.contains('1')) {
      tarjeta.value = 'Tarjeta';
    }
    if (pagos.contains('2')) {
      transferencia.value = 'Transferencia';
    }
    if (pagos.contains('3')) {
      efectivo.value = 'Efectivo';
    }
    super.onInit();
  }

  List<OpinionTrabajador> opiniones = [];
  RxString message = ''.obs;
  Future obtenerOpiniones() async {
    try {
      ApiService apiService = ApiService();

      Map<String, dynamic> body = {
        "oficio": tipo.value == 'favorito'
            ? oficio.value.idOficio
            : profesion.value.idOficio
      };

      final respuesta = await apiService.fetchData('opiniones/trabajador',
          method: Method.POST, body: body);

      if (apiService.status == 200) {
        opiniones = OpinionTrabajador.fromJsonList(respuesta);
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

  bool verEstatus() {
    bool estatus = false;

    if (tipo.value == 'favorito') {
      if (oficio.value.estatus == 'Activo') {
        estatus = true;
      } else {
        estatus = false;
      }
    } else {
      if (profesion.value.estatus == 'Activo') {
        estatus = true;
      } else {
        estatus = false;
      }
    }
    return estatus;
  }
  //Enviar mensaje o crear contacto

  RxBool hizoContacto = false.obs;
  TextEditingController mensaje = TextEditingController();
  RxString respuestaMensaje = ''.obs;

  void irMensaje() {
    mensaje.text =
        'Hola, soy ${usuario!.nombre}  ${usuario!.apellidoP ?? ''} necesito que...';
    Get.toNamed(Routes.mensaje);
  }

  Future enviarMensaje() async {
    try {
      final homeController = Get.put(HomeController());
      String fecha = DateTime.now().toLocal().toString();
      String ubicacion =
          '${homeController.ps!.latitude}, ${homeController.ps!.longitude}';

      ApiService apiService = ApiService();
      Map<String, dynamic> body = {
        "oficio": tipo.value == 'favorito'
            ? oficio.value.idOficio
            : profesion.value.idOficio,
        "usuario": usuario!.idUsuario,
        "fecha": fecha,
        "mensaje": mensaje.text,
        "localizacion": ubicacion,
        "estatus": 'Pendiente'
      };
      // print(body);
      final respuesta = await apiService.fetchData('contacto/agregar',
          method: Method.POST, body: body);
      respuestaMensaje.value = respuesta['message'];
      if (apiService.status == 200) {
        Get.back();
        Get.back();
        await snackbar('Exito', respuestaMensaje.value);
      } else {
        snackbar('Fallo', respuestaMensaje.value);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
}
