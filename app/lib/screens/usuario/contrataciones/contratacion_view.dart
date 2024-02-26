import 'package:app/config/theme.dart';
import 'package:app/helpers/api.dart';
import 'package:app/helpers/formatos.dart';

import 'package:app/models/solicitud.dart';
import 'package:app/screens/usuario/contrataciones/contratacion_controller.dart';

import 'package:app/widgets/textos.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ContratacionView extends StatelessWidget {
  const ContratacionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContratacionController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.work_history_outlined,
                      color: pink_,
                      size: 35,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: titulo('Contratos'))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: Get.width,
                child: parrafo('Hola estas son tus contrataciones:'),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: Get.width * 0.3, child: parrafo('Filtrar por:')),
                    Obx(
                      () => Container(
                        // width: Get.width * 0.5,
                        decoration: BoxDecoration(
                            color: whiteTheme_,
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.center,
                        child: DropdownButton(
                          items: const [
                            DropdownMenuItem(
                              value: 0,
                              child: Text('Activas'),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Text('Finalizadas'),
                            ),
                          ],
                          onChanged: (value) {
                            controller.identificador.value =
                                int.parse(value.toString());
                          },
                          value: controller.identificador.value,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          iconSize: 30,
                          underline: Container(),
                          style: const TextStyle(
                              color: blackTheme_,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Obx(
                () => controller.isloading.value
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : controller.solicitudes.isEmpty
                        ? SizedBox(
                            child: parrafo(controller.mensaje.value),
                          )
                        : controller.identificador.value == 0
                            ? Flexible(
                                child: ListView.builder(
                                    itemCount:
                                        controller.solicitudesActivas.length,
                                    itemBuilder: ((context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          controller.informacionContrato(
                                              controller
                                                  .solicitudesActivas[index]);
                                        },
                                        child: tarjeta(controller
                                            .solicitudesActivas[index]),
                                      );
                                    })))
                            : Flexible(
                                child: ListView.builder(
                                    itemCount: controller
                                        .solicitudesFinalizadas.length,
                                    itemBuilder: ((context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          controller.informacionContrato(
                                              controller.solicitudes[index]);
                                        },
                                        child: tarjeta(controller
                                            .solicitudesFinalizadas[index]),
                                      );
                                    }))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tarjeta(Solicitud solicitud) {
    return Center(
      child: ListTile(
        leading: CircleAvatar(
            backgroundImage: NetworkImage(solicitud.cliente!.usuario!.auth ==
                    'ninguno'
                ? '${ApiService().ruta}${solicitud.cliente!.usuario!.imagen}'
                : '${solicitud.cliente!.usuario!.imagen}')),
        title: Center(
            child: Text(
          '${solicitud.cliente!.usuario!.nombre} ${solicitud.cliente!.usuario!.apellidoP ?? ''}',
          style:
              const TextStyle(color: blackTheme_, fontWeight: FontWeight.bold),
        )),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Categoria: ${contrato.calificacion}',
            //   textAlign: TextAlign.left,
            // ),
            Text(
              'Fecha: ${Formato().formatingDateHour(solicitud.fecha.toString())}',
              textAlign: TextAlign.left,
            ),
            Text(
              'Estado: ${solicitud.estatus}',
              textAlign: TextAlign.left,
            ),
            // Text(
            //   'Estatus del Cliente: ${contrato.estatusCliente}',
            //   textAlign: TextAlign.left,
            // ),
            // Text(
            //   'Estado de la oferta: ${contrato.estado}',
            //   textAlign: TextAlign.left,
            // ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: pink_,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
