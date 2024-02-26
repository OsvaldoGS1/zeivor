import 'package:app/config/theme.dart';
import 'package:app/helpers/api.dart';
import 'package:app/screens/enviar_mensaje/detalles/detalles_controller.dart';
// import 'package:app/screens/buscar/buscar_controller.dart';
import 'package:app/widgets/textos.dart';
// import 'package:app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

class EnviarMensaje extends StatelessWidget {
  const EnviarMensaje({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetallesController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: titulo('${controller.cliente.profesion}'),
        ),
        body: Obx(
          () => controller.hizoContacto.value
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: pink_,
                        size: 70,
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                            top: 20,
                            left: 30,
                            right: 30,
                          ),
                          child: parrafoConfirmacion(
                              'Ha sido notificado ${controller.cliente.usuario!.nombre} de que requieres de sus servicios de ${controller.cliente.profesion}'
                              // controller.tipo.value ==
                              //       'favorito'
                              //   ? 'Ha sido notificado ${controller.oficio.value.nombre} de que requieres de sus servicios de ${controller.oficio.value.profesion}'
                              //   : 'Ha sido notificado ${controller.profesion.value.nombre} de que requieres de sus servicios de ${controller.profesion.value.profesion}'
                              ))
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              // controller.tipo.value == 'favorito'
                              '${controller.cliente.usuario!.nombre ?? ''} ${controller.cliente.usuario!.apellidoP ?? ''}',
                              // : '${controller.profesion.value.nombre} ${controller.profesion.value.apellidoP}',
                              style: const TextStyle(
                                  color: blackTheme_,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              '${ApiService().ruta}${controller.cliente.imagen}',
                              // controller.tipo.value == 'favorito'
                              //     ? '${ApiService().ruta}${controller.oficio.value.imagen}'
                              //     : '${ApiService().ruta}${controller.profesion.value.imagen}',
                              width: Get.width * 0.7,
                              scale: 1,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          // color: pink_,
                          child: TextFormField(
                            controller: controller.mensaje,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                hintText: 'Mensaje',
                                fillColor: whiteTheme_),
                            maxLines: 6,
                            maxLength: 250,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: pink_,
                              borderRadius: BorderRadius.circular(5)),
                          child: TextButton(
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                'Contactar',
                                style: TextStyle(
                                    color: whiteTheme_,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPressed: () async {
                              await controller.enviarMensaje();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }
}
