import 'package:app/config/theme.dart';
import 'package:app/helpers/formatos.dart';
import 'package:app/models/alerta.dart';
import 'package:app/screens/usuario/alertas/alerta_controller.dart';
import 'package:app/widgets/textos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertaView extends StatelessWidget {
  const AlertaView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlertaController>(
      builder: ((controller) => Scaffold(
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
                          child: titulo('Mis Alertas'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: parrafo(
                        'Hola ${controller.usuario!.nombre} estan son tus alertas de trabajo que has creado.'),
                  ),
                  Obx(
                    () => controller.message.value.isNotEmpty
                        ? Center(
                            child: Text(controller.message.value),
                          )
                        : Flexible(
                            child: ListView.builder(
                              itemCount: controller.alertas.length,
                              itemBuilder: ((context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(content());
                                  },
                                  child: alertas(
                                      controller.alertas[index], controller),
                                );
                              }),
                            ),
                          ),
                  ),
                  // Flexible(child: L)
                ],
              ),
            ),
          )),
    );
  }

  Widget content() {
    return Container(
      width: Get.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: whiteTheme_, borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Container(
          width: Get.width * 0.5,
          margin: const EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: blackTheme_,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const ListTile(
            leading: Icon(
              Icons.cancel,
              color: whiteTheme_,
            ),
            title: Text(
              'Cancelar',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: whiteTheme_,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
        Container(
          width: Get.width * 0.5,
          margin: const EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: blackTheme_,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const ListTile(
            leading: Icon(
              Icons.pause,
              color: whiteTheme_,
            ),
            title: Text(
              'Pausar',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: whiteTheme_,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
        Container(
          width: Get.width * 0.5,
          margin: const EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: blackTheme_,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const ListTile(
            leading: Icon(
              Icons.edit_outlined,
              color: whiteTheme_,
            ),
            title: Text(
              'Editar',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: whiteTheme_,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        )
      ]),
    );
  }

  Widget alertas(Alerta alerta, AlertaController controller) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: whiteTheme_),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(controller.estado(alerta.estatus)),
        ),
        title: Text(
          '${alerta.trabajo}'.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(color: blackTheme_),
        ),
        subtitle: Column(
          children: [
            Text(
              Formato().formatingDateHour(alerta.fecha.toString()),
              style: const TextStyle(color: blackTheme_),
            ),
            Text(
              'Estado de la alerta: ${alerta.estatus}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: blackTheme_),
            ),
            Text(
              '${alerta.descripcion}',
              style: const TextStyle(color: blackTheme_),
            ),
          ],
        ),
      ),
    );
  }
}
