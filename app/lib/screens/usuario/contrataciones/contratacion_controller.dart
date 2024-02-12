import 'package:app/helpers/api.dart';
import 'package:app/helpers/data.dart';
import 'package:app/models/contrato.dart';
import 'package:app/models/opiniones_trabajador.dart';
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
    await obtenerContratos();
    super.onInit();
  }

  List<Contrato> contratosActivas = [];
  List<Contrato> contratosFinalizadas = [];
  List<Contrato> contratos = [];

  RxString mensaje = ''.obs;
  RxBool isloading = false.obs;

  Future obtenerContratos() async {
    isloading.value = true;
    try {
      ApiService apiService = ApiService();
      Map<String, dynamic> body = {"usuario": usuario!.idUsuario};
      final respuesta = await apiService.fetchData('contratos/consulta',
          method: Method.POST, body: body);
      if (apiService.status == 200) {
        contratos = Contrato.fromJsonList(respuesta);
        contratosFinalizadas = contratos
            .where((element) =>
                element.estatusCliente == 'Terminado' &&
                element.estatusTrabajador == 'Terminado')
            .toList();
        contratosActivas = contratos
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

  RxInt identificador = 0.obs;
  // void selectFiltro(int index){
  //   if(index == 0){

  //   }
  // }

  //Ver informacion     //Ver informacion     //Ver informacion     //Ver informacion     //Ver informacion     //Ver informacion
  Contrato? contrato;
  void informacionContrato(Contrato contra) async {
    contrato = contra;
    await Get.toNamed(Routes.contratacionInformacion);
  }

  RxBool mostrarInformacion = false.obs;

  List<OpinionTrabajador> opiniones = [];
  RxString message = ''.obs;
  Future obtenerOpiniones() async {
    try {
      opiniones.clear();
      message.value = '';
      ApiService apiService = ApiService();

      Map<String, dynamic> body = {"oficio": contrato!.idOficio};

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

  ///Calificacion
  Future actualizarTrabajo() async {
    try {
      ApiService apiService = ApiService();
      Map<String, dynamic> body = {"contrato": contrato!.idContacto};
      final respuesta = await apiService.fetchData('contratos/aceptar/cliente',
          method: Method.POST, body: body);

      if (apiService.status == 200) {
        Get.back();
        Get.back();
        await snackbar(respuesta['message'], '');
      } else {
        snackbar('Error', respuesta['message']);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  RxBool agregandoFavorito = false.obs;
  RxBool estaAgregado = false.obs;
  Future agregarFavorito(int oficio) async {
    agregandoFavorito.value = true;
    try {
      ApiService apiService = ApiService();
      Map<String, dynamic> body = {
        "usuario": usuario!.idUsuario,
        "oficio": oficio
      };

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
