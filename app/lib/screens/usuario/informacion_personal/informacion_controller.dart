import 'package:app/helpers/api.dart';
import 'package:app/helpers/data.dart';
import 'package:app/helpers/seguridad.dart';
import 'package:app/models/usuario.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformacionController extends GetxController {
  Usuario usuario = Get.arguments;
  @override
  void onInit() {
    llenarTextField();
    super.onInit();
  }

  TextEditingController nombre = TextEditingController();
  TextEditingController apellido = TextEditingController();
  TextEditingController apellidoM = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool isPass = true.obs;

  void llenarTextField() {
    // if (usuario. == 'ninguno') {
    //   nombre.text = usuario.nombre.toString();
    //   apellido.text = usuario.apellidoP.toString();
    //   apellidoM.text = usuario.apellidoM.toString();
    //   correo.text = usuario.correo.toString();
    //   telefono.text = usuario.telefono.toString();
    //   password.text = pass();
    // } else {
    //   nombre.text = usuario.nombre.toString();
    //   apellido.text = usuario.apellidoP ?? '';
    //   apellidoM.text = usuario.apellidoM ?? '';
    //   correo.text = usuario.correo.toString();
    //   telefono.text = usuario.telefono ?? '';
    // }

    nombre.text = usuario.nombre.toString();
    apellido.text = usuario.apellidoP ?? "";
    apellidoM.text = usuario.apellidoM ?? "";
    correo.text = usuario.correo ?? "";
    telefono.text = usuario.telefono ?? "";
    password.text = usuario.password!.isNotEmpty ? pass() : "";
  }

  String pass() {
    return Seguridad().desencriptar(usuario.password.toString());
  }

  //Actualizar Datos del usuario

  Future actualizarDatos() async {
    try {
      ApiService apiService = ApiService();
      Map<String, dynamic> body = {};
      final respuesta =
          await apiService.fetchData('', method: Method.POST, body: body);

      if (apiService.status == 200) {
        Datos datos = Datos();
        datos.logOut();
        datos.login(respuesta['usuario']);
        Get.back();
      } else {
        snackbar('Error', respuesta['message']);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
}
