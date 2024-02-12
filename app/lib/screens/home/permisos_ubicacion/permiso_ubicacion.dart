import 'package:app/config/theme.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/screens/home/permisos_ubicacion/permiso_ubicacion_controller.dart';
import 'package:app/widgets/cerrar_sesion.dart';
import 'package:app/widgets/textos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PermisoUbicacionView extends StatelessWidget {
  const PermisoUbicacionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PermisoUbicacionController>(
      builder: (controller) => Scaffold(
        backgroundColor: whiteTheme_,
        appBar: AppBar(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: whiteTheme_,
          title: Center(
            child: Image.asset(
              'assets/images/logos/logo.png',
              scale: 25,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await cerrarSesion();
                },
                icon: const Icon(
                  Icons.power_settings_new,
                  color: blackTheme_,
                  size: 30,
                ))
          ],
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
          child: Column(children: [
            tituloCenter('Acceso a la ubicacion del dispositivo '),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: parrafoAuto(
                  'Para una mejor experiencia es necesario que habilites el acceso a la ubicacion en la configuracion de tu dispositivo'),
            ),
            GestureDetector(
              onTap: () async => await controller.openLocationSettings(),
              child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: pink_, borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    'Habilitar Ubicacion',
                    style: TextStyle(
                        color: whiteTheme_,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
