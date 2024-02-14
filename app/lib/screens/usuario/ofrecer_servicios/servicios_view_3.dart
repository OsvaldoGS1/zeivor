import 'dart:io';

import 'package:app/config/theme.dart';
import 'package:app/screens/usuario/ofrecer_servicios/servicios_controller.dart';
import 'package:app/screens/usuario/ofrecer_servicios/terminos/terminos.dart';
import 'package:app/widgets/textos.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:smile_flutter/smile_flutter.dart';
// import 'package:smile_flutter_3/smile_flutter_3.dart';

class OfrecerServiciosView3 extends StatelessWidget {
  const OfrecerServiciosView3({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiciosController>(
      builder: (controller) => Scaffold(
        backgroundColor: whiteTheme_,
        appBar: AppBar(
          backgroundColor: whiteTheme_,
          title: titulo('Paso 3'),
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(children: [
              parrafo(
                  'Prepara tu identificacion para verificar tu perfil y ubicate en un lugar con buena iluminacion.'),
              const Divider(),
              GestureDetector(
                onTap: () {
                  cameras(controller);
                },
                child: Obx(
                  () => controller.identificacion.value
                      ? Container(
                          margin: const EdgeInsets.only(top: 50, bottom: 50),
                          child: Center(
                            child: Image.file(
                                File(controller.identificacionImage.value)),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 50, bottom: 50),
                          child: Center(
                            child: Column(
                              children: [
                                parrafo(
                                  'Agregue su identificacion',
                                ),
                                const Icon(
                                  Icons.branding_watermark_outlined,
                                  color: pink_,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                ),
              ),
              const Divider(),
              GestureDetector(
                onTap: () {
                  controller.imagefromCamara();
                },
                child: Obx(
                  () => controller.selfie.value
                      ? Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 50),
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.6),
                            child: Image.file(
                              File(controller.imagenPath.value),
                              width: Get.width * 0.6,
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 50, bottom: 50),
                          child: Center(
                            child: Column(
                              children: [
                                parrafo(
                                  'Agregue una selfie',
                                ),
                                const Icon(
                                  Icons.camera_front,
                                  color: pink_,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                ),
              ),
              const Divider(),
              Container(
                margin: const EdgeInsets.only(top: 50, bottom: 50),
                child: Center(
                  child: Column(
                    children: [
                      parrafoConfirmacion(
                        'Agregue su carta de antecedentes penales (opcional)',
                      ),
                      const Icon(
                        Icons.document_scanner,
                        color: pink_,
                        size: 40,
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                      title: 'Seivor',
                      backgroundColor: whiteTheme_,
                      confirm: GestureDetector(
                        onTap: () {
                          Get.back();
                          controller.terminos.value = true;
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: pink_,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            'Aceptar',
                            style: TextStyle(
                                color: whiteTheme_,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      content: SingleChildScrollView(child: terminos()));
                },
                child: Container(
                  margin: const EdgeInsets.all(17),
                  child: GestureDetector(
                    child: const Text(
                      'Leer aviso de privacidad, terminos y condiciones',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: blackTheme_, fontSize: 17),
                    ),
                  ),
                ),
              ),
              Obx(
                () => controller.terminos.value
                    ? GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 40),
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: pink_,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            'Registrarse',
                            style: TextStyle(
                                color: whiteTheme_,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future cameras(ServiciosController controller) {
    return Get.bottomSheet(Container(
      height: Get.height * 0.2,
      decoration: BoxDecoration(
          color: whiteTheme_, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          const Text(
            'Elija una opcion:',
            style: TextStyle(
                color: blackTheme_, fontSize: 21, fontWeight: FontWeight.bold),
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.identificacionGaleria();
                    },
                    child: SizedBox(
                      width: Get.width * 0.4,
                      child: const Column(
                        children: [
                          Text(
                            'Galeria',
                            style: TextStyle(color: blackTheme_, fontSize: 19),
                          ),
                          Icon(
                            Icons.photo,
                            size: 35,
                            color: pink_,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.identificacionCamara();
                    },
                    child: SizedBox(
                      width: Get.width * 0.4,
                      child: const Column(
                        children: [
                          Text(
                            'Camara',
                            style: TextStyle(color: blackTheme_, fontSize: 19),
                          ),
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 35,
                            color: pink_,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
          )
        ],
      ),
    ));
  }

  Widget terminos() {
    return SizedBox(
      height: Get.height * 0.6,
      child: SingleChildScrollView(child: Text(Terminos().aviso)),
    );
  }
}
