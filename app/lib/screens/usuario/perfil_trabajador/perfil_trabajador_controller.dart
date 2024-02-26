import 'dart:io';

import 'package:app/helpers/data.dart';
import 'package:app/helpers/obtener_oficio.dart';
import 'package:app/models/cliente.dart';
// import 'package:app/models/oficio.dart';
import 'package:app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PerfilTrabajadorController extends GetxController {
  RxBool isloading = false.obs;
  Cliente? cliente;
  Usuario? usuario;

  @override
  void onInit() async {
    isloading.value = true;
    usuario = Datos().recoveryData();
    cliente = await DatosCliente().datosCliente(usuario!);
    llenarDatos();
    if (cliente!.imagenesTrabajo!.isEmpty) {
      imagenesIsEmpty.value = true;
    } else {
      imagenesCliente.value = cliente!.imagenesTrabajo!.toList();
      imagenesIsEmpty.value = false;
    }
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
    profesion.text = cliente!.profesion ?? '';
    descripcion.text = cliente!.descripcion ?? '';
    celularContacto.text = cliente!.celular ?? '';

    calle.text = cliente!.direccion!.calle ?? '';
    colonia.text = cliente!.direccion!.colonia ?? '';
    cp.text = cliente!.direccion!.cp.toString();
    municipio.text = cliente!.direccion!.municipio ?? '';
    estado.text = cliente!.direccion!.estado ?? '';
    pais.text = cliente!.direccion!.pais ?? '';
  }

  RxList<String> imagenesCliente = <String>[].obs;

  RxList<File> imagenes = <File>[].obs;
  RxBool imagenesIsEmpty = false.obs;

  List<File> obtenerListaDeImagenesFromGallery() {
    Future<void> seleccionarImagenesDesdeGaleria() async {
      List<XFile>? result = await ImagePicker().pickMultiImage(
        imageQuality: 85,
        maxWidth: 800,
      );

      if (result != null) {
        imagenes.value += result.map((XFile file) => File(file.path)).toList();
        imagenesIsEmpty.value = true;
      }
    }

    seleccionarImagenesDesdeGaleria();
    return imagenes;
  }

  List<File> obtenerListaDeImagenesFromCamara() {
    imagenesIsEmpty.value = false;
    Future<void> capturarImagenDesdeCamara() async {
      XFile? result = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 800,
      );

      if (result != null) {
        imagenes.add(File(result.path));
        imagenesIsEmpty.value = true;
      }
    }

    capturarImagenDesdeCamara();
    return imagenes;
  }

  // RxList<String> imagenes = <String>[].obs;

  Future pickImageFromGallery() async {
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage();

    if (pickedImages != null && pickedImages.isNotEmpty) {
      return pickedImages;
    }

    return [];
  }

  Future pickImageFromCamera() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // Aquí puedes manejar la imagen tomada desde la cámara
      // La ruta de la imagen está en pickedImage.path
    }
  }
}
