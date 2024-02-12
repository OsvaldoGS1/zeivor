import 'package:app/config/theme.dart';
// import 'package:app/helpers/estilo_map.dart';
import 'package:app/screens/ubicacion/ubicacion_controller.dart';
import 'package:app/widgets/calificar.dart';
import 'package:app/widgets/cancelar.dart';
import 'package:app/widgets/incidente.dart';
import 'package:app/widgets/textos.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as mapa;

class UbicacionView extends StatelessWidget {
  const UbicacionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UbicacionController>(builder: (controller) {
      return Scaffold(
        backgroundColor: whiteTheme_,
        appBar: AppBar(
          title: Obx(
            () => Row(
              children: [
                Icon(
                  !controller.verMapa.value ? Icons.notifications : Icons.route,
                  color: pink_,
                  size: 35,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: titulo(!controller.verMapa.value
                        ? 'Notificaciones'
                        : 'Ubicación')),
              ],
            ),
          ),
        ),
        body: Obx(
          () => !controller.verMapa.value
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                          color: whiteTheme_,
                          borderRadius: BorderRadius.circular(100)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.done,
                          color: pink_,
                          size: 100,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                          color: whiteTheme_,
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: parrafo('Excelente decision!')),
                    ),
                    SizedBox(
                      child: parrafoConfirmacion(
                          '${controller.oferta.nombre} ${controller.oferta.apellidoP ?? ''}, te espera para contratar tus servicios.'),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: pink_, borderRadius: BorderRadius.circular(5)),
                      child: TextButton(
                        onPressed: () {
                          controller.verMapa.value = !controller.verMapa.value;
                        },
                        child: const Text(
                          'Ver mapa',
                          style: TextStyle(
                              color: whiteTheme_,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    controller.oferta.estatusTrabajador == 'Terminado'
                        ? controller.oferta.estatusCliente == 'En proceso'
                            ? Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 15),
                                      child: const Icon(
                                        Icons.warning,
                                        color: pink_,
                                      ),
                                    ),
                                    Flexible(
                                      child: parrafo(
                                          'Solicita al cliente que de por terminado el trabajo para poder hacer el comentario'),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 40),
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: blackTheme_,
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextButton(
                                  onPressed: () {
                                    Get.bottomSheet(
                                        DraggableScrollableSheet(
                                            initialChildSize: 0.7,
                                            maxChildSize: 0.7,
                                            expand: false,
                                            minChildSize: 0.4,
                                            builder:
                                                (context, scrollcontroller) {
                                              return calificarCliente(
                                                  controller.oferta);
                                            }),
                                        isScrollControlled: true,
                                        backgroundColor: whiteTheme_);
                                  },
                                  child: const Text(
                                    'Evaluar al cliente',
                                    style: TextStyle(
                                        color: whiteTheme_,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                        : Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 40),
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: pink_,
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextButton(
                                  onPressed: () {
                                    // controller.verMapa.value = !controller.verMapa.value;
                                    Get.bottomSheet(
                                        DraggableScrollableSheet(
                                            initialChildSize: 0.7,
                                            maxChildSize: 0.7,
                                            expand: false,
                                            minChildSize: 0.4,
                                            builder:
                                                (context, scrollcontroller) {
                                              return cancelar(2);
                                            }),
                                        isScrollControlled: true,
                                        backgroundColor: whiteTheme_);
                                  },
                                  child: const Text(
                                    'Cancelar trabajo',
                                    style: TextStyle(
                                        color: whiteTheme_,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 40),
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: pink_,
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextButton(
                                  onPressed: () {
                                    // controller.verMapa.value = !controller.verMapa.value;
                                    Get.bottomSheet(
                                        DraggableScrollableSheet(
                                            initialChildSize: 0.7,
                                            maxChildSize: 0.7,
                                            expand: false,
                                            minChildSize: 0.4,
                                            builder:
                                                (context, scrollcontroller) {
                                              return incidente();
                                            }),
                                        isScrollControlled: true,
                                        backgroundColor: whiteTheme_);
                                  },
                                  child: const Text(
                                    'Reportar incidente',
                                    style: TextStyle(
                                        color: whiteTheme_,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 40),
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: pink_,
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextButton(
                                  onPressed: () {
                                    // controller.verMapa.value = !controller.verMapa.value;
                                    Get.defaultDialog(
                                      title: 'Trabajo',
                                      backgroundColor: whiteTheme_,
                                      content: SizedBox(
                                        child: Column(
                                          children: [
                                            parrafo(
                                                'Para finalizar tu trabajo solo confirma. (una vez confirmado el trabajo no podra cambiar de estatus)'),
                                          ],
                                        ),
                                      ),
                                      buttonColor: pink_,
                                      textConfirm: 'Confirmar',
                                      textCancel: 'Cancelar',
                                      onConfirm: () async {
                                        // Get.back();
                                        await controller.terminarTrabajo();
                                      },
                                    );
                                  },
                                  child: const Text(
                                    'Completar trabajo',
                                    style: TextStyle(
                                        color: whiteTheme_,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          )
                  ]),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: Get.width,
                        height: Get.height * 0.3,
                        child: GoogleMap(
                          rotateGesturesEnabled: false,
                          scrollGesturesEnabled: false,
                          zoomControlsEnabled: false,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          mapType: MapType.normal,
                          markers: {
                            Marker(
                              markerId: const MarkerId('trabajo'),
                              position: controller.posicion!,
                            )
                          },
                          zoomGesturesEnabled: false,
                          gestureRecognizers: <Factory<
                              OneSequenceGestureRecognizer>>{
                            Factory<OneSequenceGestureRecognizer>(
                              () => EagerGestureRecognizer(),
                            ),
                          },
                          onMapCreated: (controller) {
                            // controller.setMapStyle(MapaEstilo().estilo);
                          },
                          initialCameraPosition:
                              controller.initialCameraPosition!,
                        ),
                      ),
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: whiteTheme_,
                            borderRadius: BorderRadius.circular(20)),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              titulo('Datos personales'),
                              Container(
                                alignment: Alignment.topLeft,
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.people,
                                    color: blackTheme_,
                                  ),
                                  title: parrafo(
                                      'Nombre: ${controller.oferta.nombre} ${controller.oferta.apellidoP ?? ''} ${controller.oferta.apellidoM ?? ''}'
                                          .toUpperCase()),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await controller.launchPhone('6692120410');
                                },
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.phone,
                                      color: blackTheme_,
                                    ),
                                    title: parrafo(
                                        'Telefono: ${controller.oferta.telefono ?? 'Sin numero de telefono'}'),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await controller.launcEmail();
                                },
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: ListTile(
                                      leading: const Icon(Icons.email),
                                      title: parrafo(
                                          'Correo: ${controller.oferta.correo ?? 'Sin correo electronico'} ')),
                                ),
                              ),
                              titulo('Dirección'),
                              parrafo(
                                  '${controller.lugar!.thoroughfare} #${controller.lugar!.subThoroughfare}'),
                              parrafo('Col.${controller.lugar!.subLocality}'),
                              parrafo('Cp.${controller.lugar!.postalCode}'),
                              parrafo(
                                  '${controller.lugar!.locality}, ${controller.lugar!.administrativeArea}'),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                    color: pink_,
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextButton(
                                  child: const Text(
                                    'Ver Ruta',
                                    style: TextStyle(
                                        color: whiteTheme_,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () async {
                                    await controller.metodo();
                                    await Get.bottomSheet(
                                        SizedBox(
                                          child: Column(
                                            children: [
                                              Container(
                                                child: titulo('Mapas'),
                                              ),
                                              Flexible(
                                                  child: ListView.builder(
                                                      itemCount: controller
                                                          .appmaps.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return GestureDetector(
                                                          onTap: () async {
                                                            await controller
                                                                .launchMapa(
                                                                    controller
                                                                            .appmaps[
                                                                        index]);
                                                          },
                                                          child: mapas(
                                                              controller
                                                                      .appmaps[
                                                                  index]),
                                                        );
                                                      }))
                                            ],
                                          ),
                                        ),
                                        backgroundColor: whiteTheme_);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      );
    });
  }

  Widget mapas(mapa.AvailableMap mapa) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: SvgPicture.asset(
          mapa.icon,
          width: 50,
          height: 50,
          // fit: BoxFit.cover,
        ),
      ),
      title: Container(
        alignment: Alignment.center,
        child: parrafo(mapa.mapName),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: pink_,
      ),
    );
  }
}
