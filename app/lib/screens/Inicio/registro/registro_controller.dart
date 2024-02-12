import 'package:app/config/theme.dart';
import 'package:app/helpers/api.dart';
import 'package:app/helpers/data.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistroController extends GetxController {
  TextEditingController nombre = TextEditingController();
  TextEditingController apellido = TextEditingController();
  TextEditingController apellidoM = TextEditingController();
  TextEditingController celular = TextEditingController();
  TextEditingController correo = TextEditingController();

  RxBool acepto = false.obs;
  RxBool isLoading = false.obs;

  Future validar() async {
    isLoading.value = true;

    if (nombre.text.isEmpty) {
      snackbar('Error', 'Llene el campo de nombre');
      return;
    }
    if (apellido.text.isEmpty) {
      snackbar('Error', 'Llene el campo de Apellido paterno');
      return;
    }
    if (apellidoM.text.isEmpty) {
      snackbar('Error', 'Llene el campo de Apellido Materno');
      return;
    }
    if (celular.text.isEmpty || celular.text.length < 10) {
      snackbar('Error', 'Escriba su numero celular');
      return;
    }
    if (correo.text.isEmpty) {
      snackbar('Error', 'Coloque su correo electronico');
      return;
    }
    await registrarse();
    isLoading.value = false;
  }

  Future registrarse() async {
    try {
      DateTime fecha = DateTime.now().toLocal();
      Map<String, dynamic> body = {
        "correo": correo.text,
        "nombre": nombre.text,
        "apellido": apellido.text,
        "apellidoM": apellidoM.text,
        "telefono": celular.text.toString(),
        "fecha": fecha.toString()
      };

      ApiService apiService = ApiService();
      final respuesta = await apiService.fetchData('usuario/registro',
          method: Method.POST, body: body);

      if (apiService.status == 200) {
        Datos datos = Datos();
        datos.logOut();
        await datos.login(respuesta['usuario']);
        // await Get.offAllNamed(Routes.home);
        await mensaje();
      } else {
        snackbar('Error', respuesta['message']);
      }
    } catch (error) {
      snackbar('Error', error.toString());
    }
  }

  Future mensaje() async {
    return Get.defaultDialog(
            title: 'Bienvenido a SEIVOR',
            content: const SizedBox(
              child: Text(
                'Tu contraseña fue enviada por correo electronico',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            onConfirm: () {
              Get.offAllNamed(Routes.home);
            },
            confirmTextColor: whiteTheme_,
            contentPadding: const EdgeInsets.all(5))
        .then((value) {
      Get.offAllNamed(Routes.home);
    });
  }
}
