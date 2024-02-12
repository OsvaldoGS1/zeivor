import 'package:app/config/theme.dart';
import 'package:app/helpers/api.dart';
import 'package:app/screens/usuario/contrataciones/contratacion_controller.dart';
import 'package:app/widgets/calificar.dart';
import 'package:app/widgets/cancelar.dart';
import 'package:app/widgets/estrellas.dart';
import 'package:app/widgets/incidente.dart';
import 'package:app/widgets/opinion.dart';
import 'package:app/widgets/textos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformacionContratacionView extends StatelessWidget {
  const InformacionContratacionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContratacionController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                titulo('${controller.contrato!.profesion}'),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        backgroundColor:
                            Colors.transparent, // Color de fondo transparente
                        radius: 50, // Tamaño del círculo
                        backgroundImage: NetworkImage(
                          controller.contrato!.tipo == 'ninguno'
                              ? '${ApiService().ruta}${controller.contrato!.usuarioImagen}'
                              : '${controller.contrato!.usuarioImagen}',
                        ),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          parrafo(
                              '${controller.contrato!.nombre} ${controller.contrato!.apellidoP ?? ''} ${controller.contrato!.apellidoM ?? ''}'
                                  .toUpperCase()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StarRating(double.parse(controller
                                  .contrato!.calificacion
                                  .toString())),
                              parrafo(
                                  '  (${controller.contrato!.calificacion})'),
                            ],
                          )
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
                                    return opinion(controller.opiniones[index]);
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
                          decoration: TextDecoration.underline,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: parrafo('${controller.contrato!.descripcion}'),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.circle,
                        color: pink_,
                        size: 15,
                      ),
                    ),
                    parrafoAuto(
                        'Estatus trabajador: ${controller.contrato!.estatusTrabajador}'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.circle,
                        color: pink_,
                        size: 15,
                      ),
                    ),
                    parrafoAuto(
                        'Estatus del cliente: ${controller.contrato!.estatusCliente}'),
                  ],
                ),
                Obx(
                  () => TextButton.icon(
                      onPressed: () {
                        controller.mostrarInformacion.value =
                            !controller.mostrarInformacion.value;
                      },
                      icon: controller.mostrarInformacion.value
                          ? const Icon(Icons.arrow_drop_up)
                          : const Icon(Icons.arrow_drop_down),
                      label: Text(controller.mostrarInformacion.value
                          ? 'Ver menos informacion'
                          : 'Ver mas informacion')),
                ),
                Obx(
                  () => controller.mostrarInformacion.value
                      ? Container(
                          width: Get.width,
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Numero de telefono: ${controller.contrato!.celular}',
                                      style: const TextStyle(
                                          color: blackTheme_, fontSize: 17),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.phone,
                                          color: pink_,
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'Correo electronico: ${controller.contrato!.correo}',
                                        style: const TextStyle(
                                            color: blackTheme_, fontSize: 17),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.email,
                                          color: pink_,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ),
                SizedBox(
                  height: Get.height * 0.06,
                ),
                controller.contrato!.estatusCliente == 'Terminado'
                    ? controller.contrato!.estatusTrabajador == 'Terminado'
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.bottomSheet(
                                      DraggableScrollableSheet(
                                          initialChildSize: 0.7,
                                          maxChildSize: 0.7,
                                          expand: false,
                                          minChildSize: 0.4,
                                          builder: (context, scrollcontroller) {
                                            return calificar(
                                                controller.contrato!);
                                          }),
                                      isScrollControlled: true,
                                      backgroundColor: whiteTheme_);
                                },
                                child: Container(
                                  width: Get.width,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: blackTheme_,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Text(
                                    'Calificar al trabajador',
                                    style: TextStyle(
                                        color: whiteTheme_,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Obx(() => controller.agregandoFavorito.value
                                  ? Container(
                                      margin: const EdgeInsets.only(top: 30),
                                      child: const Column(
                                        children: [
                                          Text(
                                            'Agregando a favoritos',
                                            style: TextStyle(
                                                color: blackTheme_,
                                                fontSize: 18),
                                          ),
                                          Center(
                                            child: CircularProgressIndicator
                                                .adaptive(
                                              backgroundColor: pink_,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : controller.estaAgregado.value
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(top: 30),
                                          child: Column(
                                            children: [
                                              parrafoAuto(
                                                'Agregado a favoritos',
                                              ),
                                              // GestureDetector(
                                              //   child: Container(
                                              //     width: Get.width,
                                              //     alignment: Alignment.center,
                                              //     margin: const EdgeInsets.only(
                                              //         top: 15),
                                              //     padding:
                                              //         const EdgeInsets.all(8),
                                              //     decoration: BoxDecoration(
                                              //         color: pink_,
                                              //         borderRadius:
                                              //             BorderRadius.circular(
                                              //                 5)),
                                              //     child: const Text(
                                              //       'Quitar de favoritos',
                                              //       style: TextStyle(
                                              //           color: whiteTheme_,
                                              //           fontSize: 20,
                                              //           fontWeight:
                                              //               FontWeight.bold),
                                              //     ),
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            await controller.agregarFavorito(
                                                int.parse(controller
                                                    .contrato!.idOficio
                                                    .toString()));
                                          },
                                          child: Container(
                                            width: Get.width,
                                            alignment: Alignment.center,
                                            margin:
                                                const EdgeInsets.only(top: 15),
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: pink_,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Text(
                                              'Agregar a favoritos',
                                              style: TextStyle(
                                                  color: whiteTheme_,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ))
                            ],
                          )
                        : SizedBox(
                            child: parrafoAuto(
                                'Solicite al trabajador que marque como terminado el trabajo para realizar la evaluacion del trabajo'),
                          )
                    : Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                  DraggableScrollableSheet(
                                      initialChildSize: 0.7,
                                      maxChildSize: 0.7,
                                      expand: false,
                                      minChildSize: 0.4,
                                      builder: (context, scrollcontroller) {
                                        return cancelar(1);
                                      }),
                                  isScrollControlled: true,
                                  backgroundColor: whiteTheme_);
                            },
                            child: Container(
                              width: Get.width,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: pink_,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text(
                                'Cancelar servicio',
                                style: TextStyle(
                                    color: whiteTheme_,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                  DraggableScrollableSheet(
                                      initialChildSize: 0.7,
                                      maxChildSize: 0.7,
                                      expand: false,
                                      minChildSize: 0.4,
                                      builder: (context, scrollcontroller) {
                                        return incidente();
                                      }),
                                  isScrollControlled: true,
                                  backgroundColor: whiteTheme_);
                            },
                            child: Container(
                              width: Get.width,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(3),
                              margin: const EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                  color: pink_,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text(
                                'Reportar incidente',
                                style: TextStyle(
                                    color: whiteTheme_,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.defaultDialog(
                                title: 'Trabajo',
                                backgroundColor: whiteTheme_,
                                content: SizedBox(
                                  child: Column(
                                    children: [
                                      parrafo(
                                          'Para finalizar el trabajo solo confirma. (una vez confirmado el trabajo no podra cambiar de estatus)'),
                                    ],
                                  ),
                                ),
                                buttonColor: pink_,
                                textConfirm: 'Confirmar',
                                textCancel: 'Cancelar',
                                onConfirm: () async {
                                  // Get.back();
                                  await controller.actualizarTrabajo();
                                },
                              );
                              // Get.bottomSheet(
                              //     DraggableScrollableSheet(
                              //         initialChildSize: 0.7,
                              //         maxChildSize: 0.7,
                              //         expand: false,
                              //         minChildSize: 0.4,
                              //         builder: (context, scrollcontroller) {
                              //           return calificar(controller.contrato!);
                              //         }),
                              //     isScrollControlled: true,
                              //     backgroundColor: whiteTheme_);
                            },
                            child: Container(
                              width: Get.width,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(3),
                              margin: const EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                  color: pink_,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text(
                                'Servicio Completo',
                                style: TextStyle(
                                    color: whiteTheme_,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
