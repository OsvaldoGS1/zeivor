import 'package:app/config/theme.dart';
import 'package:app/screens/buscar/buscar_controller.dart';
import 'package:app/widgets/textos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget boton(evento, String texto, bool esAfirmativo) {
  return GestureDetector(
    onTap: () {
      evento;
    },
    child: Container(
      decoration: BoxDecoration(color: esAfirmativo ? pink_ : whiteTheme_),
      child: Text(
        texto,
        style: TextStyle(
            color: esAfirmativo ? whiteTheme_ : blackTheme_,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

// Future alertaContacto(BuscarController controller) async {
//   return Get.defaultDialog(
//     title: 'Ubicación',
//     backgroundColor: whiteTheme_,
//     content: parrafoConfirmacion(
//         '¿El servicio es para tu ubicación actual o es en otra ubicación?'),
//     // textConfirm: 'Si',
//     // textCancel: 'Otra ubicación',
//     // cancelTextColor: blackTheme_,
//     // confirmTextColor: whiteTheme_,
//     // buttonColor: blackTheme_,
//     // onConfirm: () async {
//     //   await lanzarMapa();
//     // },
//     cancel: boton(() {
//       Get.back();
//     }, 'Es otra ubicacion', false),
//     confirm: boton(controller.lanzarMapa(), 'Si', true),
//   );
// }
