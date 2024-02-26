import 'dart:convert';
import 'dart:io';

import 'package:app/config/theme.dart';
import 'package:app/helpers/data.dart';
import 'package:app/helpers/obtener_oficio.dart';
import 'package:app/models/cliente.dart';
// import 'package:app/helpers/position.dart';
// import 'package:app/models/oficio.dart';
import 'package:app/models/usuario.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../helpers/api.dart';

class UsuarioController extends GetxController {
  Usuario? usuario;
  RxString imagenPath = ''.obs;
  // Position? ps; // = Get.arguments;

  RxBool estatus = true.obs;
  Cliente? cliente;
  RxBool isloading = false.obs;

  @override
  void onInit() async {
    isloading.value = true;
    usuario = Datos().recoveryData();

    if (usuario!.tipoUsuario == "Cliente") {
      cliente = await DatosCliente().datosCliente(usuario!);
      if (cliente!.estatus == 'Activo') {
        estatus.value = true;
      } else {
        estatus.value = false;
      }
      if (cliente!.estatus == 'Validando') {
        snackbarOscura('Tu perfil esta en proceso de validacion', '');
      }
    }
    imagenPath.value = obtenerRuta();
    isloading.value = false;
    super.onInit();
  }

  String obtenerRuta() {
    String rutaImagen = '';
    print(usuario!.imagen);
    if (usuario!.auth == 'ninguno') {
      rutaImagen = '${ApiService().ruta}${usuario!.imagen}';
    } else {
      rutaImagen = usuario!.imagen ?? '';
    }

    return rutaImagen;
  }

  RxString imagenCircular = ''.obs;
  Future imagenfromGaleriaa() async {
    final imagen = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagen != null) {
      await croppedFile(imagen.path);
    }
  }

  Future imagefromCamara() async {
    final camara = await ImagePicker().pickImage(source: ImageSource.camera);
    if (camara != null) {
      await croppedFile(camara.path);
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
        cropStyle: CropStyle.circle,
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
      imagenCircular.value = croppedFile.path;
      await actualizarImagen();
    }
  }

  Future actualizarImagen() async {
    Uri url = Uri.parse('${ApiService().baseUrl}/usuario/imagen');
    try {
      var request = http.MultipartRequest('POST', url);

      request.fields['usuario'] = usuario!.sId.toString();
      if (imagenCircular.isNotEmpty) {
        File img = File(imagenCircular.value);
        http.ByteStream stream =
            http.ByteStream.fromBytes(img.readAsBytesSync());
        int length = await img.length();

        var multipartFile =
            http.MultipartFile('imagen', stream, length, filename: img.path);
        request.files.add(multipartFile);
      }
      final respuesta = await http.Response.fromStream(await request.send());
      if (respuesta.statusCode == 200) {
        Get.back();
        Get.back();
        Get.snackbar('Imagen actualizada', '',
            colorText: whiteTheme_,
            backgroundColor: blackTheme_,
            snackPosition: SnackPosition.TOP);
        Map<String, dynamic> jsonMap = jsonDecode(respuesta.body);
        Datos datos = Datos();
        datos.logOut();
        datos.login(jsonMap['usuario']);
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

  Future cambiarEstatus() async {
    try {
      Map<String, dynamic> body = {
        "cliente": cliente!.sId,
        "estatus": estatus.value ? 'Inactivo' : 'Activo'
      };
      ApiService apiService = ApiService();

      await apiService.fetchData('cliente/estatus',
          method: Method.POST, body: body);
      if (apiService.status == 200) {
        cliente = await DatosCliente().datosCliente(usuario!);
      }
      // print(oficio);
      if (cliente!.estatus == 'Activo') {
        estatus.value = true;
      } else {
        estatus.value = false;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
        print("Error en el servidor");
      }
    }
  }
}
