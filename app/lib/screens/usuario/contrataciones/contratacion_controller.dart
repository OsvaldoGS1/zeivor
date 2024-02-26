import 'package:app/helpers/api.dart';
import 'package:app/helpers/data.dart';
import 'package:app/models/contrato.dart';
import 'package:app/models/opiniones_trabajador.dart';
import 'package:app/models/solicitud.dart';
import 'package:app/models/usuario.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ContratacionController extends GetxController {
  Usuario? usuario;
  @override
  void onInit() async {
    usuario = Datos().recoveryData();
    // await obtenerContratos();
    await obtenerSolicitudes();
    super.onInit();
  }

  RxString mensaje = ''.obs;
  RxBool isloading = false.obs;

  RxInt identificador = 0.obs;

  List<Solicitud> solicitudes = [];
  List<Solicitud> solicitudesActivas = [];
  List<Solicitud> solicitudesFinalizadas = [];

  Future obtenerSolicitudes() async {
    try {
      ApiService apiService = ApiService();
      Map<String, dynamic> body = {"solicitante": usuario!.sId};
      final respuesta = await apiService.fetchData(
          'solicitud/obtener/solicitante',
          method: Method.POST,
          body: body);
      if (apiService.status == 200) {
        solicitudes = Solicitud.fromJsonList(respuesta);
        solicitudesFinalizadas = solicitudes
            .where((element) =>
                element.estatusCliente == 'Terminado' &&
                element.estatusSolicitante == 'Terminado')
            .toList();
        solicitudesActivas = solicitudes
            .where((element) => element.estatusCliente != 'Terminado')
            .toList();
        mensaje.value = '';
      } else {
        mensaje.value = respuesta['message'];
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error al obtener los contratos $error");
      }
    }
    isloading.value = false;
  }

  //Ver informacion     //Ver informacion     //Ver informacion     //Ver informacion     //Ver informacion     //Ver informacion
  Solicitud? solicitud;
  void informacionContrato(Solicitud soli) async {
    solicitud = soli;
    await Get.toNamed(Routes.contratacionInformacion);
  }

  RxBool mostrarInformacion = false.obs;

  List<OpinionTrabajador> opiniones = [];
  RxString message = ''.obs;
  // Future obtenerOpiniones() async {
  //   try {
  //     opiniones.clear();
  //     message.value = '';
  //     ApiService apiService = ApiService();

  //     Map<String, dynamic> body = {"oficio": contrato!.idOficio};

  //     final respuesta = await apiService.fetchData('opiniones/trabajador',
  //         method: Method.POST, body: body);

  //     if (apiService.status == 200) {
  //       opiniones = OpinionTrabajador.fromJsonList(respuesta);
  //       message.value = '';
  //     } else {
  //       message.value = respuesta['message'];
  //     }
  //   } catch (error) {
  //     if (kDebugMode) {
  //       print(error);
  //     }
  //   }
  // }

  ///Calificacion
  // Future actualizarTrabajo() async {
  //   try {
  //     ApiService apiService = ApiService();
  //     Map<String, dynamic> body = {"contrato": contrato!.idContacto};
  //     final respuesta = await apiService.fetchData('contratos/aceptar/cliente',
  //         method: Method.POST, body: body);

  //     if (apiService.status == 200) {
  //       Get.back();
  //       Get.back();
  //       await snackbar(respuesta['message'], '');
  //     } else {
  //       snackbar('Error', respuesta['message']);
  //     }
  //   } catch (error) {
  //     if (kDebugMode) {
  //       print(error);
  //     }
  //   }
  // }

  RxBool agregandoFavorito = false.obs;
  RxBool estaAgregado = false.obs;
  Future agregarFavorito(int oficio) async {
    agregandoFavorito.value = true;
    try {
      ApiService apiService = ApiService();
      Map<String, dynamic> body = {"usuario": usuario!.sId, "oficio": oficio};

      // await Future.delayed(const Duration(seconds: 3));
      final respuesta = await apiService.fetchData('favoritos/agregar',
          method: Method.POST, body: body);

      if (apiService.status == 200) {
        snackbar(respuesta['message'], '');
        estaAgregado.value = true;
      } else {
        snackbar('Error', respuesta['message']);
        estaAgregado.value = false;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    agregandoFavorito.value = false;
  }
}
