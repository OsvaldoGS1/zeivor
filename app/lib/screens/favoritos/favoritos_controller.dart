import 'package:app/helpers/api.dart';
import 'package:app/helpers/data.dart';
import 'package:app/models/cliente.dart';

import 'package:app/models/favorito.dart';

import 'package:app/models/usuario.dart';
import 'package:app/routes/app_pages.dart';

import 'package:app/widgets/snackbar.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class FavoritosController extends GetxController {
  Usuario? usuario;

  @override
  void onInit() async {
    obtenerUsuario();

    // await buscarFavoritos();
    super.onInit();
  }

  void obtenerUsuario() {
    usuario = Datos().recoveryData();
  }

  RxBool isloading = false.obs;
  RxInt valorDrop = 1.obs;
  RxBool isFavorite = true.obs;

  // List<Favorito> lista = [];
  List<Cliente> lista = [];
  RxString message = ''.obs;

  Future buscarFavoritos() async {
    isloading.value = true;
    try {
      ApiService apiService = ApiService();
      Map<String, dynamic> body = {"usuario": usuario!.sId};
      final respuesta = await apiService.fetchData('favorito/obtener',
          method: Method.POST, body: body);
      // print(respuesta);
      if (apiService.status == 200) {
        lista = Cliente.fromJsonList(respuesta);
        // print(lista);
      } else {
        message.value = respuesta['message'];
      }
      // print(respuesta);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    isloading.value = false;
  }

  ///Enviar mensaje a profesionista

  Rx<Favorito> oficio = Favorito().obs;
  RxBool hizoContacto = false.obs;
  RxString tarjeta = ''.obs;
  RxString transferencia = ''.obs;
  RxString efectivo = ''.obs;

  // final home = Get.put(HomeController());

  //Mensaje

  TextEditingController mensaje = TextEditingController();
  void irMensaje(Favorito favorito) {
    oficio.value = favorito;
    mensaje.text = 'Hola, solicito de sus servicios';
    Get.toNamed(Routes.mensaje);
  }

  Future contacto(Position? ps) async {
    try {
      String fecha = DateTime.now().toLocal().toString();
      // Position? ps = home.
      // print(ps);
      Map<String, dynamic> body = {
        "oficio": oficio.value.idOficio,
        "usuario": usuario!.sId,
        "fecha": fecha,
        "mensaje": mensaje.text,
        "localizacion": '${ps!.latitude}, ${ps.longitude}',
        "estatus": 'Activo',
      };
      ApiService apiService = ApiService();

      final respuesta = await apiService.fetchData('contacto/agregar',
          method: Method.POST, body: body);
      snackbar('Mensaje', respuesta['message']);
      if (apiService.status == 200) {
        hizoContacto.value = true;
      } else {
        hizoContacto.value = false;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  //Detalles
  void irDetalles(Favorito profesion) {
    oficio.value = profesion;
    List oficios = oficio.value.metodosPago!.split(',');
    if (oficios.contains('1')) {
      tarjeta.value = 'Tarjeta';
    }
    if (oficios.contains('2')) {
      transferencia.value = 'Transferencia';
    }
    if (oficios.contains('3')) {
      efectivo.value = 'Efectivo';
    }
    Get.toNamed(Routes.detalles);
  }

  // void irMensaje(ProfesionistasDisponibles profesion) {
  //   BuscarController.oficio.value = profesion;
  //   Get.toNamed(Routes.mensaje);
  // }
}
