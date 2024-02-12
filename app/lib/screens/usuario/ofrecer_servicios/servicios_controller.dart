import 'dart:convert';
import 'dart:io';

import 'package:app/config/theme.dart';
import 'package:app/helpers/api.dart';
import 'package:app/helpers/data.dart';
import 'package:app/models/usuario.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ServiciosController extends GetxController {
  RxBool efectivo = false.obs;
  RxBool tarjeta = false.obs;
  RxBool transferencia = false.obs;
  RxString imagenPath = ''.obs;

  RxBool cobroVisita = true.obs;

  Usuario? usuario;

  @override
  void onInit() {
    usuario = Datos().recoveryData();
    celular.text = usuario!.telefono ?? '123';
    super.onInit();
  }

  Future imagenfromGaleriaa() async {
    final imagen = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagen != null) {
      await croppedFile(imagen.path);
    }
  }

  Future imagefromCamara() async {
    final imagen = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
    if (imagen != null) {
      await croppedFile(imagen.path);
    }
  }

  Future croppedFile(pickedFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile,
        compressFormat: ImageCompressFormat.jpg,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: const [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        cropStyle: CropStyle.rectangle,
        compressQuality: 20,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Editar imagen',
            cropGridColumnCount: 2,
            cropGridRowCount: 2,
            cropGridStrokeWidth: 1,
            activeControlsWidgetColor: pink_,
            initAspectRatio: CropAspectRatioPreset.original,
            toolbarColor: pink_,
            toolbarWidgetColor: whiteTheme_,
          ),
          IOSUiSettings(
            title: 'Editar imagen',
            cancelButtonTitle: 'Cancelar',
            doneButtonTitle: 'Aceptar',
            aspectRatioLockEnabled: true,
            aspectRatioPickerButtonHidden: true,
            resetButtonHidden: true,
            rotateButtonsHidden: true,
            rotateClockwiseButtonHidden: true,
          ),
        ]);
    if (croppedFile != null) {
      imagenPath.value = croppedFile.path;
    }
  }

  TextEditingController profesion = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController celular = TextEditingController();
  // TextEditingController profesion = TextEditingController();

  String obtenerMetodosPago() {
    String valor = '';
    if (tarjeta.value) {
      valor += "1,";
    }
    if (transferencia.value) {
      valor += "2,";
    }
    if (efectivo.value) {
      valor += "3";
    }
    return valor;
  }

  Future volverseProfesionista() async {
    try {
      Uri url = Uri.parse('${ApiService().baseUrl}/profesionista/crear');
      var request = http.MultipartRequest('POST', url);

      String metodos = obtenerMetodosPago();
      request.fields['usuario'] = usuario!.idUsuario.toString();
      request.fields['profesion'] = profesion.text;
      request.fields['descripcion'] = descripcion.text;
      request.fields['metodos'] = metodos;
      request.fields['celular'] = celular.text;

      if (imagenPath.isNotEmpty) {
        File img = File(imagenPath.value);
        http.ByteStream stream =
            http.ByteStream.fromBytes(img.readAsBytesSync());
        int length = await img.length();
        var multipartFile =
            http.MultipartFile('imagen', stream, length, filename: img.path);
        request.files.add(multipartFile);
      }
      final respuesta = await http.Response.fromStream(await request.send());
      if (respuesta.statusCode == 200) {
        snackbar('Felicidades por tu registro', '');
        await Get.offAllNamed(Routes.home);
      } else {
        Get.back();
        final mensaje = jsonDecode(respuesta.body);
        Get.snackbar(mensaje['message'], '',
            colorText: whiteTheme_, backgroundColor: blackTheme_);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
  // Datos de direccion 2

  RxBool tieneDireccion = true.obs;
  RxBool ocultarDireccion = false.obs;

  //Datos de Identificacion
  RxBool identificacion = false.obs;
  RxBool selfie = false.obs;

  RxString identificacionImage = ''.obs;

  Future identificacionGaleria() async {
    final imagen = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagen != null) {
      await identificacionImagen(imagen.path);
    }
  }

  Future identificacionCamara() async {
    final imagen = await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagen != null) {
      await identificacionImagen(imagen.path);
    }
  }

  Future identificacionImagen(pickedFile) async {
    final id = await ImageCropper().cropImage(
        sourcePath: pickedFile,
        compressFormat: ImageCompressFormat.jpg,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: const [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        cropStyle: CropStyle.rectangle,
        compressQuality: 20,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Editar imagen',
            cropGridColumnCount: 2,
            cropGridRowCount: 2,
            cropGridStrokeWidth: 1,
            activeControlsWidgetColor: pink_,
            initAspectRatio: CropAspectRatioPreset.original,
            toolbarColor: pink_,
            toolbarWidgetColor: whiteTheme_,
          ),
          IOSUiSettings(
            title: 'Editar imagen',
            cancelButtonTitle: 'Cancelar',
            doneButtonTitle: 'Aceptar',
            aspectRatioLockEnabled: true,
            aspectRatioPickerButtonHidden: true,
            resetButtonHidden: true,
            rotateButtonsHidden: true,
            rotateClockwiseButtonHidden: true,
          ),
        ]);
    if (id != null) {
      identificacion.value = true;
      identificacionImage.value = id.path;
    }
  }

  RxBool terminos = false.obs;
}
