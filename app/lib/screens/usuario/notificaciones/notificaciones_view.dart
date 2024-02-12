import 'package:app/config/theme.dart';
import 'package:app/helpers/api.dart';
import 'package:app/helpers/formatos.dart';
import 'package:app/models/oferta.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/screens/usuario/notificaciones/notificaciones_controller.dart';
import 'package:app/widgets/textos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificacionesView extends StatelessWidget {
  const NotificacionesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificacionesController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
            // elevation: 1,
            ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.notifications,
                    color: pink_,
                    size: 35,
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: titulo('Notificaciones')),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: parrafo(
                    'Hola ${controller.usuario!.nombre}, estos clientes quieren tus servicios'),
              ),
              Obx(
                () => controller.isloading.value
                    ? Container(
                        margin: const EdgeInsets.only(top: 100),
                        child: const Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: pink_,
                          ),
                        ),
                      )
                    : Flexible(
                        child: ListView.builder(
                          itemCount: controller.ofertas.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () async {
                                if (controller.ofertas[index].estatus ==
                                    'Aceptada') {
                                  await Get.toNamed(Routes.ubicacion,
                                      arguments: controller.ofertas[index]);
                                } else {
                                  await Get.toNamed(Routes.notiMensaje,
                                      arguments: [
                                        controller.ofertas[index],
                                        controller.ps
                                      ]);
                                }
                              },
                              child:
                                  noti(controller.ofertas[index], controller),
                            );
                          }),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget noti(Oferta oferta, NotificacionesController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: ListTile(
        leading: CircleAvatar(
            backgroundImage: NetworkImage(oferta.tipo == 'ninguno'
                ? '${ApiService().ruta}${oferta.imagen}'
                : '${oferta.imagen}')),
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(50),
        //   child: Image.asset('assets/images/logos/user.jpg'),
        // ),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            '${oferta.nombre} ${oferta.apellidoP ?? ''}'.toUpperCase(),
            style: const TextStyle(
                color: blackTheme_, fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                  'Te contacto ${Formato().formatoHoraDia(oferta.fecha.toString())}'),
              Text(
                'Esta a ${controller.distancia(
                  oferta.localizacion.toString(),
                )} de tu ubicacion',
                style: const TextStyle(
                  color: blackTheme_,
                ),
              )
            ],
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
