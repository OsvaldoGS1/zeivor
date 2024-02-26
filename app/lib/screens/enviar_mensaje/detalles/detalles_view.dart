import 'package:app/config/theme.dart';
import 'package:app/helpers/api.dart';
// import 'package:app/helpers/formatos.dart';
// import 'package:app/models/opiniones_trabajador.dart';
// import 'package:app/routes/app_pages.dart';
import 'package:app/screens/enviar_mensaje/detalles/detalles_controller.dart';
import 'package:app/widgets/estrellas.dart';
import 'package:app/widgets/opinion.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:app/widgets/textos.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetallesView extends StatelessWidget {
  const DetallesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetallesController>(
      builder: (controller) => Scaffold(
        backgroundColor: whiteTheme_,
        appBar: AppBar(
          backgroundColor: whiteTheme_,
          elevation: 0,
          title: SizedBox(
            child: Text(
              controller.cliente.profesion!.toUpperCase(),
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
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 30),
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        '${ApiService().ruta}${controller.cliente.imagen}',
                        width: Get.width,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: whiteTheme_,
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                          icon: const Icon(
                            Icons.image,
                            color: blackTheme_,
                            size: 34,
                          ),
                          onPressed: () async {
                            controller.cliente.imagenesTrabajo!.isNotEmpty
                                ? await masImagenes(controller)
                                : snackbarOscura('Sin imagenes', '');
                          },
                        ),
                      ),
                    ),
                  ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    controller.cliente.usuario!.imagen!.isEmpty
                        ? CircleAvatar(
                            radius: 45,
                            backgroundColor: pink_,
                            child: Text(
                              controller.cliente.usuario!.nombre![0],
                              style: const TextStyle(
                                  color: whiteTheme_,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(controller
                                        .cliente.usuario!.auth ==
                                    "ninguno"
                                ? "${ApiService().ruta}${controller.cliente.usuario!.imagen}"
                                : controller.cliente.usuario!.imagen
                                    .toString()),
                          ),
                    SizedBox(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            width: Get.width * 0.6,
                            child: AutoSizeText(
                              '${controller.cliente.usuario!.nombre}  ${controller.cliente.usuario!.apellidoP ?? ''} ${controller.cliente.usuario!.apellidoM ?? ''}',
                              maxFontSize: 22,
                              minFontSize: 17,
                              style: const TextStyle(
                                  color: blackTheme_,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                StarRating(
                                  double.parse(controller.cliente.calificacion
                                      .toString()),
                                ),
                                Flexible(
                                  child: Text(
                                    controller.cliente.calificacion.toString(),
                                    style: const TextStyle(
                                        color: blackTheme_,
                                        fontWeight: FontWeight.bold),
                                  ),
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
                    // controller.tipo.value == 'favorito'
                    //     ? '${controller.oficio.value.descripcion}'
                    //     : '${controller.profesion.value.descripcion}',
                    '${controller.cliente.descripcion}',
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
                controller.cliente.metodosPago!.efectivo!
                    ? Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Efectivo',
                          style: TextStyle(
                              color: blackTheme_,
                              fontSize: 18,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    : const SizedBox(),
                controller.cliente.metodosPago!.tarjeta!
                    ? Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Tarjeta',
                          style: TextStyle(
                              color: blackTheme_,
                              fontSize: 18,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    : const SizedBox(),
                controller.cliente.metodosPago!.efectivo!
                    ? Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Transferencia',
                          style: TextStyle(
                              color: blackTheme_,
                              fontSize: 18,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    : const SizedBox(),
                controller.cliente.estatus == 'Activo'
                    ? Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: pink_,
                            borderRadius: BorderRadius.circular(5)),
                        child: TextButton(
                          child: const Text(
                            'Enviar mensaje',
                            style: TextStyle(
                                color: whiteTheme_,
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            // Get.toNamed(Routes.mensaje);
                            controller.irMensaje();
                          },
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future masImagenes(DetallesController controller) async {
    return Get.bottomSheet(
      Container(
        height: Get.height * 0.91,
        width: Get.width,
        decoration: BoxDecoration(
            color: whiteTheme_, borderRadius: BorderRadius.circular(35)),
        child: Column(
          children: [
            Container(
              height: 7,
              margin: const EdgeInsets.only(top: 10, bottom: 50),
              width: Get.width / 4,
              decoration: BoxDecoration(
                  color: blackTheme_, borderRadius: BorderRadius.circular(50)),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                'Total de imagenes: ${controller.cliente.imagenesTrabajo!.length}',
                style: const TextStyle(
                    color: blackTheme_,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
                child: ListView.builder(
                    itemCount: controller.cliente.imagenesTrabajo!.length,
                    // itemExtent: Get.width * 0.7,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            '${ApiService().ruta}${controller.cliente.imagenesTrabajo![index]}',
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              );
                            },
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
      backgroundColor: whiteTheme_,
      isScrollControlled: true,
    );
  }
}
