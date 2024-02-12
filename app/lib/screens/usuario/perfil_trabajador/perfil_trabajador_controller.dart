import 'package:app/helpers/data.dart';
import 'package:app/helpers/obtener_oficio.dart';
import 'package:app/models/oficio.dart';
import 'package:app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerfilTrabajadorController extends GetxController {
  RxBool isloading = false.obs;
  Oficio? oficio;
  Usuario? usuario;
  @override
  void onInit() async {
    isloading.value = true;
    usuario = Datos().recoveryData();
    oficio = await DatosOficio().datosOficio(usuario!);
    llenarDatos();
    isloading.value = false;
    super.onInit();
  }

  RxString tarjeta = ''.obs;
  RxString transferencia = ''.obs;
  RxString efectivo = ''.obs;

  RxBool isTarjeta = false.obs;
  RxBool isTransferencia = false.obs;
  RxBool isEfectivo = false.obs;

  RxBool mostrarDireccion = false.obs;

  TextEditingController profesion = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController celularContacto = TextEditingController();
  TextEditingController referencia1 = TextEditingController();
  TextEditingController referencia2 = TextEditingController();
  TextEditingController referencia3 = TextEditingController();
  TextEditingController montoController = TextEditingController();
  TextEditingController calle = TextEditingController();
  TextEditingController colonia = TextEditingController();
  TextEditingController cp = TextEditingController();
  TextEditingController municipio = TextEditingController();
  TextEditingController estado = TextEditingController();
  TextEditingController pais = TextEditingController();

  void llenarDatos() {
    profesion.text = oficio!.profesion ?? '';
    descripcion.text = oficio!.descripcion ?? '';
    celularContacto.text = oficio!.celular ?? '';
    referencia1.text = oficio!.referencia1 ?? '';
    referencia2.text = oficio!.referencia2 ?? '';
    referencia3.text = oficio!.referencia3 ?? '';
    montoController.text = oficio!.visitaCobro ?? '';
    if (oficio!.visible.toString() == 'si') {
      mostrarDireccion.value = true;
    } else {
      mostrarDireccion.value = false;
    }

    calle.text = oficio!.calle ?? '';
    colonia.text = oficio!.colonia ?? '';
    cp.text = oficio!.cp ?? '';
    municipio.text = oficio!.municipio ?? '';
    estado.text = oficio!.estado ?? '';
    pais.text = oficio!.pais ?? '';

    List pagos = [];
    pagos = oficio!.metodosPago!.split(',');
    if (pagos.contains('1')) {
      tarjeta.value = 'Tarjeta';
      isTarjeta.value = true;
    }
    if (pagos.contains('2')) {
      transferencia.value = 'Transferencia';
      isTransferencia.value = true;
    }
    if (pagos.contains('3')) {
      efectivo.value = 'Efectivo';
      isEfectivo.value = true;
    }
  }
}
