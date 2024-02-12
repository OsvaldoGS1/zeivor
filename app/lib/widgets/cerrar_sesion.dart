import 'package:app/config/theme.dart';
import 'package:app/helpers/data.dart';
import 'package:app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart';

Future cerrarSesion() async {
  return await Get.defaultDialog(
    title: "¿Desea cerrar sesión?",

    titleStyle: const TextStyle(
        color: blackTheme_, fontSize: 19, fontWeight: FontWeight.bold),
    backgroundColor: whiteTheme_,
    content: const SizedBox(),

    textConfirm: 'Si',
    textCancel: 'No',
    cancelTextColor: blackTheme_,
    // middleTextStyle: cTextStyle(color: whiteTheme_, fontWeight: FontWeight.bold),
    confirmTextColor: whiteTheme_,
    buttonColor: pink_,
    onConfirm: () {
      cerrar();
    },
  );
}

void cerrar() {
  Datos datos = Datos();
  datos.logOut();
  Get.offAllNamed(Routes.login);
}
