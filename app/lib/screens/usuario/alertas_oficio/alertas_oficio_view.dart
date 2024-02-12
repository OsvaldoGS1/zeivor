import 'package:app/config/theme.dart';
import 'package:app/helpers/formatos.dart';
import 'package:app/models/alerta_oficio.dart';
import 'package:app/screens/usuario/alertas_oficio/alertas_oficio_controller.dart';
import 'package:app/widgets/textos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertasOficioView extends StatelessWidget {
  const AlertasOficioView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlertasOficioController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(),
        body: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.alarm,
                        color: pink_,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: titulo('Alertas'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: parrafo(
                      'Hola ${controller.usuario!.nombre} estan son las alertas de trabajo en las cuales tu perfil coincide.'),
                ),
                Obx(() => controller.message.value.isNotEmpty
                    ? Center(
                        child: Text('${controller.message}'),
                      )
                    : Flexible(
                        child: ListView.builder(
                            itemCount: controller.alertas.length,
                            itemBuilder: ((context, index) {
                              return alertas(
                                  controller.alertas[index], controller);
                            })),
                      ))
              ],
            )),
      ),
    );
  }

  Widget alertas(AlertaOficio alerta, AlertasOficioController controller) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          color: whiteTheme_, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              'Fecha: ${Formato().formatingDateHour(alerta.fecha.toString())}',
              style: const TextStyle(color: blackTheme_, fontSize: 17),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: const CircleAvatar(
                    backgroundColor: pink_,
                    child: Text(
                      'S',
                      style: TextStyle(
                          color: whiteTheme_, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: Get.width * 0.6,
                  alignment: Alignment.center,
                  child: Text(
                    'Nombre: ${alerta.nombre} ${alerta.apellidoP ?? ''} ${alerta.apellidoM ?? ''}',
                    style: const TextStyle(color: blackTheme_, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: parrafo('${alerta.trabajo}'.toUpperCase()),
          ),
          Container(
            alignment: Alignment.center,
            child: parrafo('Descripcion: ${alerta.descripcion}'),
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              'Para ver mas informacion es necesario aceptar el trabajo.',
              style: TextStyle(color: blackTheme_),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    await Get.defaultDialog(
                      title: 'Estatus',
                      backgroundColor: whiteTheme_,
                      content: SizedBox(
                        child: Column(
                          children: [
                            parrafo('¿Estas seguro de esta descision?'),
                          ],
                        ),
                      ),
                      buttonColor: pink_,
                      textConfirm: 'Confirmar',
                      textCancel: 'Cancelar',
                      onConfirm: () async {
                        Get.back();
                        // await controller.cambiarEstatus();
                        // await controller.aceptarAlerta(alerta);
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: blackTheme_,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      'No aceptar la oferta',
                      style: TextStyle(
                          color: whiteTheme_,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Get.defaultDialog(
                      title: 'Estatus',
                      backgroundColor: whiteTheme_,
                      content: SizedBox(
                        child: Column(
                          children: [
                            parrafo(
                                '¿Estas seguro de aceptar esta oferta de trabajo?'),
                          ],
                        ),
                      ),
                      buttonColor: pink_,
                      textConfirm: 'Confirmar',
                      textCancel: 'Cancelar',
                      onConfirm: () async {
                        Get.back();
                        // await controller.cambiarEstatus();
                        await controller.aceptarAlerta(alerta);
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: pink_, borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      'Aceptar',
                      style: TextStyle(
                          color: whiteTheme_,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
