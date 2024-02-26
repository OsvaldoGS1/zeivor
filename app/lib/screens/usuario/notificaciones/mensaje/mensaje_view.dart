import 'package:app/config/theme.dart';
import 'package:app/helpers/api.dart';
import 'package:app/helpers/formatos.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/screens/usuario/notificaciones/mensaje/mensaje_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MensajeView extends StatelessWidget {
  const MensajeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MensajeController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          // controller:
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(
                            controller.oferta.solicitante!.auth == 'ninguno'
                                ? '${ApiService().ruta}${controller.oferta.solicitante!.imagen}'
                                : '${controller.oferta.solicitante!.imagen}',
                            // width: Get.width * 0.35,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              '${controller.oferta.solicitante!.nombre} ${controller.oferta.solicitante!.apellidoP ?? ''}'
                                  .toUpperCase(),
                              style: const TextStyle(
                                  color: blackTheme_,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                                'Te contacto ${Formato().formatoHoraDia(controller.oferta.fecha.toString())}')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                      'El cliente se encuentra a: ${controller.distancia(controller.oferta.localizacion.toString())} de tu ubicacion.'),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hola ${controller.usuario!.nombre}'.toUpperCase(),
                    style: const TextStyle(color: blackTheme_, fontSize: 18),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${controller.oferta.mensaje}',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(color: blackTheme_, fontSize: 17),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: blackTheme_,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: TextButton(
                            child: const Text(
                              'Rechazar',
                              style: TextStyle(
                                  color: whiteTheme_,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: pink_,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: TextButton(
                            child: const Text(
                              'Aceptar',
                              style: TextStyle(
                                  color: whiteTheme_,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              await controller.aceptarOferta();
                              // Get.toNamed(Routes.ubicacion);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
