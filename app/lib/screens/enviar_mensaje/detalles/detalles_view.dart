import 'package:app/config/theme.dart';
import 'package:app/helpers/api.dart';
import 'package:app/helpers/formatos.dart';
import 'package:app/models/opiniones_trabajador.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/screens/enviar_mensaje/detalles/detalles_controller.dart';
import 'package:app/widgets/estrellas.dart';
import 'package:app/widgets/opinion.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:app/screens/buscar/buscar_controller.dart';
// import 'package:app/screens/favoritos/favoritos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetallesView extends StatelessWidget {
  const DetallesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetallesController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: SizedBox(
            child: Text(
              controller.tipo.value == 'favorito'
                  ? '${controller.oficio.value.profesion}'.toUpperCase()
                  : '${controller.profesion.value.profesion}'.toUpperCase(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                  color: blackTheme_,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                        controller.tipo.value == 'favorito'
                            ? controller.oficio.value.tipo == 'ninguno'
                                ? '${ApiService().ruta}${controller.oficio.value.usuarioImagen}'
                                : '${controller.oficio.value.usuarioImagen}'
                            : controller.profesion.value.tipo == 'ninguno'
                                ? '${ApiService().ruta}${controller.profesion.value.usuarioImagen}'
                                : '${controller.profesion.value.usuarioImagen}',
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            width: Get.width * 0.6,
                            child: AutoSizeText(
                              controller.tipo.value == 'favorito'
                                  ? '${controller.oficio.value.nombre} ${controller.oficio.value.apellidoP ?? ''} ${controller.oficio.value.apellidoM ?? ''}'
                                      .toUpperCase()
                                  : '${controller.profesion.value.nombre} ${controller.profesion.value.apellidoP ?? ''} ${controller.profesion.value.apellidoM ?? ''}'
                                      .toUpperCase(),
                              maxFontSize: 19,
                              minFontSize: 14,
                              style: const TextStyle(
                                color: blackTheme_,
                              ),
                            ),
                          ),
                          SizedBox(
                            // alignment: Alignment.center,
                            // height: 50,
                            width: Get.width * 0.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                StarRating(
                                  double.parse(
                                    controller.tipo.value == 'favorito'
                                        ? controller.oficio.value.calificacion
                                            .toString()
                                        : controller
                                            .profesion.value.calificacion
                                            .toString(),
                                  ),
                                ),
                                Flexible(
                                  child: Text(controller.tipo.value ==
                                          'favorito'
                                      ? ' (${controller.oficio.value.calificacion})'
                                      : ' (${controller.profesion.value.calificacion})'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      controller.tipo.value == 'favorito'
                          ? '${ApiService().ruta}${controller.oficio.value.imagen}'
                          : '${ApiService().ruta}${controller.profesion.value.imagen}',
                      width: Get.width,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () async {
                        await controller.obtenerOpiniones();
                        Get.defaultDialog(
                          title: 'Opiniones',
                          backgroundColor: whiteTheme_,
                          content: SizedBox(
                            width: Get.width * 0.9,
                            height: Get.height * 0.45,
                            child: controller.opiniones.isEmpty
                                ? Center(
                                    child: Text(
                                    '${controller.message}',
                                    style: const TextStyle(
                                        color: blackTheme_, fontSize: 17),
                                  ))
                                : ListView.builder(
                                    itemCount: controller.opiniones.length,
                                    itemBuilder: (context, index) {
                                      return opinion(
                                          controller.opiniones[index]);
                                    }),
                          ),
                          cancel: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: pink_,
                                  borderRadius: BorderRadius.circular(5)),
                              width: Get.width * 0.9,
                              child: const Text(
                                'Cerrar',
                                style: TextStyle(
                                    color: whiteTheme_,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Ver opiniones',
                        style: TextStyle(
                            fontSize: 17,
                            color: blackTheme_,
                            decoration: TextDecoration.underline),
                      )),
                ),
                SizedBox(
                  child: Text(
                    controller.tipo.value == 'favorito'
                        ? '${controller.oficio.value.descripcion}'
                        : '${controller.profesion.value.descripcion}',
                    style: const TextStyle(color: blackTheme_, fontSize: 19),
                  ),
                ),
                // Text('${controller.profesion.value.usuarioImagen}'),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    'Metodos de pago: ',
                    style: TextStyle(
                        color: blackTheme_,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${controller.efectivo}',
                    style: const TextStyle(
                        color: blackTheme_,
                        fontSize: 18,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${controller.tarjeta}',
                    style: const TextStyle(
                        color: blackTheme_,
                        fontSize: 18,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${controller.transferencia}',
                    style: const TextStyle(
                        color: blackTheme_,
                        fontSize: 18,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                !controller.verEstatus()
                    ? const SizedBox()
                    : Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: pink_,
                            borderRadius: BorderRadius.circular(5)),
                        child: TextButton(
                          child: const Text(
                            'Enviar mensaje',
                            style: TextStyle(
                                color: whiteTheme_,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            // Get.toNamed(Routes.mensaje);
                            controller.irMensaje();
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
