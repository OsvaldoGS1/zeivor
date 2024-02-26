import 'package:app/helpers/api.dart';
import 'package:app/helpers/data.dart';
import 'package:app/models/cliente.dart';
// import 'package:app/models/favorito.dart';
import 'package:app/models/opinion.dart';

// import 'package:app/models/profesionista_disponibles.dart';
import 'package:app/models/usuario.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/screens/home/home_controller.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetallesController extends GetxController {
  RxString tipo = ''.obs;

  RxBool isActivo = false.obs;
  Usuario? usuario;

  Cliente cliente = Get.arguments;
  @override
  void onInit() {
    usuario = Datos().recoveryData();
    mensaje.text =
        'Hola, soy ${usuario!.nombre}  ${usuario!.apellidoP ?? ''} necesito que...';

    super.onInit();
  }

  List<Opinion> opiniones = [];
  RxString message = ''.obs;
  Future obtenerOpiniones() async {
    try {
      ApiService apiService = ApiService();

      Map<String, dynamic> body = {"cliente": cliente.sId};

      final respuesta = await apiService.fetchData('opinion/cliente',
          method: Method.POST, body: body);

      if (apiService.status == 200) {
        opiniones = Opinion.fromJsonList(respuesta);
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

  // Future obtenerOpiniones() async {}

  //Enviar mensaje o crear contacto

  RxBool hizoContacto = false.obs;
  TextEditingController mensaje = TextEditingController();
  RxString respuestaMensaje = ''.obs;

  void irMensaje() {
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
        "solicitante": usuario!.sId,
        "cliente": cliente.sId,
        "fecha": fecha,
        "mensaje": mensaje.text,
        "localizacion": ubicacion
      };
      // print(body);
      final respuesta = await apiService.fetchData('solicitud/directa',
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
