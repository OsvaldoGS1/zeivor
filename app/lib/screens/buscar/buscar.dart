// import 'dart:math';

import 'package:app/config/theme.dart';
import 'package:app/helpers/api.dart';
import 'package:app/models/cliente.dart';
import 'package:app/models/profesionista_disponibles.dart';
import 'package:app/routes/app_pages.dart';
// import 'package:app/routes/app_pages.dart';
import 'package:app/screens/buscar/buscar_controller.dart';
// import 'package:app/screens/favoritos/favoritos_controller.dart';
import 'package:app/screens/home/home_controller.dart';
import 'package:app/widgets/estrellas.dart';
import 'package:app/widgets/textos.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class BuscarView extends StatelessWidget {
  const BuscarView({super.key});

  @override
  Widget build(BuildContext context) {
    // GoogleMapController mapController;
    var controlador = Get.put(HomeController());
    // Placemark? lugar = controlador.lugar;
    return GetBuilder<BuscarController>(
        builder: (controller) => SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                          DraggableScrollableSheet(
                              expand: false,
                              initialChildSize: 0.9,
                              maxChildSize: 0.9,
                              minChildSize: 0.2,
                              builder: (context, controllerS) {
                                return Container(
                                    width: Get.width,
                                    decoration: const BoxDecoration(
                                        color: whiteTheme_,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                    child: DefaultTabController(
                                      length: 2,
                                      initialIndex: 0,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 5),
                                            width: Get.width * 0.20,
                                            height: 7,
                                            decoration: BoxDecoration(
                                                color: blackTheme_,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                          ),
                                          Container(
                                            alignment: Alignment.topCenter,
                                            child: const TabBar(
                                              indicatorColor: pink_,
                                              labelColor: pink_,
                                              unselectedLabelColor: blackTheme_,
                                              tabs: [
                                                Tab(
                                                  icon: Icon(Icons.search),
                                                  text: 'Alerta',
                                                ),
                                                Tab(
                                                  text: 'Busqueda',
                                                  icon:
                                                      Icon(Icons.manage_search),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                              child: TabBarView(
                                            children: [
                                              SingleChildScrollView(
                                                child: bottom1(controller,
                                                    controlador.lugar),
                                              ),
                                              SingleChildScrollView(
                                                  child: bottom2(controller,
                                                      controlador.lugar))
                                            ],
                                          ))
                                        ],
                                      ),
                                    ));
                              }),
                          isScrollControlled: true);
                    },
                    child: Container(
                      width: Get.width,
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: whiteTheme_,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Hola ${controller.usuario!.nombre!.toUpperCase()}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: blackTheme_,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                                top: 20, bottom: 20, left: 10, right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: blackTheme_,
                                  style: BorderStyle.none,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.search,
                                  color: pink_,
                                  size: 35,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: const Text(
                                    '¿Qué estás BUSCANDO?',
                                    style: TextStyle(
                                        color: blackTheme_,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget bottom1(BuscarController controller, Placemark? lugar) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: whiteTheme_, borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                controller: controller.buscadorAlerta,
                onChanged: (value) {
                  controller.respuestaAPI.value = '';
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    hintText: '¿Qué estás BUSCANDO?',
                    hintStyle: TextStyle(
                        color: blackTheme_,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    prefixIcon: Icon(
                      Icons.search,
                      color: pink_,
                      size: 40,
                    )),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: whiteTheme_, borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                // autofocus: true,
                controller: controller.descripcion,
                maxLength: 100,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  hintText: 'Descripcion (opcional)',
                  hintStyle: TextStyle(
                      color: blackTheme_,
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Obx(
              () => !controller.creandoAlerta.value
                  ? Column(
                      children: [
                        Container(
                          width: Get.width * 0.8,
                          alignment: Alignment.center,
                          child: Text(
                            'Estas ubicado en: \n${lugar!.thoroughfare}, Col. ${lugar.subLocality}, ${lugar.subAdministrativeArea}, ${lugar.administrativeArea}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: blackTheme_, fontSize: 18),
                          ),
                        ),
                        controller.respuestaAPI.value.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Text(
                                  controller.respuestaAPI.value,
                                  maxLines: 4,
                                  style: const TextStyle(
                                      color: blackTheme_, fontSize: 16),
                                ),
                              )
                            : const SizedBox()
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
            ),
            GestureDetector(
              onTap: () async {
                // await controller.crearAlerta();
                await controller.pregunta();
              },
              child: Container(
                width: Get.width,
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: pink_, borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  'Crear Alerta',
                  style: TextStyle(
                      color: whiteTheme_,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget bottom2(BuscarController controller, Placemark? lugar) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin:
              const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          decoration: BoxDecoration(
              color: whiteTheme_, borderRadius: BorderRadius.circular(5)),
          child: TextFormField(
            controller: controller.buscador,
            onChanged: (value) {
              controller.respuestaAPI.value = '';
            },
            onEditingComplete: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              await controller.buscar();
            },
            // autofocus: true,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                hintText: '¿Qué estás BUSCANDO?',
                hintStyle: TextStyle(
                    color: blackTheme_,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
                prefixIcon: Icon(
                  Icons.search,
                  color: pink_,
                  size: 40,
                )),
          ),
        ),
        GestureDetector(
          onTap: () async {
            await controller.lanzarMapa(false);
          },
          child: Container(
            width: Get.width * 0.8,
            margin: const EdgeInsets.only(bottom: 10),
            alignment: Alignment.center,
            child: const Text(
              // 'Estas ubicado en: \n${lugar!.thoroughfare}, Col. ${lugar.subLocality} ${lugar.subAdministrativeArea}, ${lugar.administrativeArea}',
              'Cambiar lugar de busqueda',
              textAlign: TextAlign.center,

              style: TextStyle(
                  color: blackTheme_,
                  fontSize: 17,
                  decoration: TextDecoration.underline),
            ),
          ),
        ),
        Obx(() => controller.isloading.value
            ? const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: blackTheme_,
                ),
              )
            : controller.resultados.isNotEmpty
                ? Column(
                    children: [
                      SizedBox(
                          child: parrafoAuto(
                              'Total de resultados: ${controller.resultados.length} ')),
                      Container(
                        height: Get.height * 0.4,
                        margin: const EdgeInsets.all(1),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.resultados.length,
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                  bottom: 0, top: 10, left: 20, right: 20),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.detalles,
                                      arguments: controller.resultados[index]);
                                },
                                child: tarjeta(
                                  controller.resultados[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: parrafo(controller.respuestaAPI2.value),
                  )),
      ],
    );
  }

  Widget tarjeta(Cliente cliente) {
    return Stack(children: [
      Container(
        // margin: EdgeInsets.only(bottom: Get.height * 0.07),
        width: Get.width * 0.9,
        // height: Get.height * 0.5,
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          child: Image.network(
            '${ApiService().ruta}${cliente.imagen}',
            fit: BoxFit.fill,
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          margin: const EdgeInsets.only(bottom: 1),
          decoration: BoxDecoration(
            color: whiteTheme_,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(top: 5),
                child: Text(
                  '${cliente.profesion} ${cliente.usuario!.nombre}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
              SizedBox(
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: Get.width * 0.5,
                        height: 50,
                        child: StarRating(
                            double.parse(cliente.calificacion.toString()))),
                    Text(
                      '${cliente.calificacion}',
                      style: const TextStyle(color: blackTheme_, fontSize: 17),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: parrafoAuto('${cliente.descripcion}'),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
