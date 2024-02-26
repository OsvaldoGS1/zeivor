import 'package:app/config/theme.dart';
import 'package:app/helpers/api.dart';
import 'package:app/helpers/data.dart';
import 'package:app/helpers/formatos.dart';
import 'package:app/models/estado.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistroController extends GetxController {
  @override
  void onInit() async {
    await obtenerEstados();
    // print(estados);
    super.onInit();
  }

  RxList<Estado> estados = <Estado>[].obs;
  Future obtenerEstados() async {
    try {
      ApiService apiService = ApiService();
      final respuesta =
          await apiService.fetchData('estados/', method: Method.GET);
      if (apiService.status == 200) {
        estados.value = Estado.fromJsonList(respuesta);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  RxBool isLoading = false.obs;

  RxInt identificador = 0.obs;

  TextEditingController nombre = TextEditingController();
  TextEditingController apellido = TextEditingController();
  TextEditingController apellidoM = TextEditingController();
  TextEditingController celular = TextEditingController();
  TextEditingController correo = TextEditingController();

  RxString sexo = ''.obs;

  // Rx<DateTime> selectedDate = DateTime.now().toLocal().obs;
  DateTime? selectedDate;
  RxString nacimiento = ''.obs;
  RxString estado = ''.obs;

  Future selectDate(BuildContext context) async {
    final fecha = DateTime(
        DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);
    DateTime? picked = await showDatePicker(
      context: context,
      barrierColor: whiteTheme_.withOpacity(0.5),
      initialDate: fecha,
      firstDate: DateTime(1910),
      lastDate: fecha,
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      nacimiento.value = Formato().formatingDate(selectedDate!.toString());
    }
  }

  RxBool acepto = false.obs;

  Future validar() async {
    isLoading.value = true;
    try {
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
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future registrarse() async {
    try {
      DateTime fecha = DateTime.now().toLocal();
      Map<String, dynamic> body = {
        "correo": correo.text.toLowerCase(),
        "nombre": nombre.text.toUpperCase(),
        "apellido": apellido.text.toUpperCase(),
        "apellidoM": apellidoM.text.toUpperCase(),
        "telefono": celular.text.toString(),
        "fecha": fecha.toString(),
        "sexo": sexo.value,
        "nacimiento": selectedDate!.toLocal().toString(),
        "estado": estado.value
      };

      // print(body);
      ApiService apiService = ApiService();
      final respuesta = await apiService.fetchData('usuario/registro',
          method: Method.POST, body: body);
      // print(respuesta);
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
      print(error);
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
