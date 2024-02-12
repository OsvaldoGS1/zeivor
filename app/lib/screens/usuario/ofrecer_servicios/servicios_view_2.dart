import 'dart:io';

import 'package:app/config/theme.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/screens/usuario/ofrecer_servicios/servicios_controller.dart';
import 'package:app/screens/usuario/ofrecer_servicios/terminos/terminos.dart';
import 'package:app/widgets/textos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:smile_flutter/smile_flutter.dart';
// import 'package:smile_flutter_3/smile_flutter_3.dart';

class OfrecerServiciosView2 extends StatelessWidget {
  const OfrecerServiciosView2({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiciosController>(
      builder: (controller) => Scaffold(
          backgroundColor: whiteTheme_,
          appBar: AppBar(
            title: titulo('Paso 2'),
            backgroundColor: whiteTheme_,
          ),
          body: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(
                    () => SizedBox(
                      child: Row(
                        children: [
                          parrafo('¿Cuentas con una dirección?'),
                          CupertinoCheckbox(
                              activeColor: pink_,
                              value: controller.tieneDireccion.value,
                              onChanged: (value) {
                                controller.tieneDireccion.value =
                                    !controller.tieneDireccion.value;
                              }),
                        ],
                      ),
                    ),
                  ),
                  Obx(() => controller.tieneDireccion.value
                      ? SizedBox(
                          // duration: const Duration(seconds: 10),
                          // curve: Curves.fastOutSlowIn,
                          child: Column(children: [
                            parrafoAuto(
                                'Nota: Esta direccion se le mostrara al cliente para acudir en caso de ser necesario a tu negocio.'),
                            input('Calle: ', 100),
                            input('Colonia: ', 75),
                            input('C.P: ', 5),
                            input('Municipio: ', 10),
                            input('Estado: ', 10),
                            input('Pais: ', 10),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: Row(
                                children: [
                                  parrafoAuto(
                                      '¿Deseas ocultar la direccion de tu negocio?:'),
                                  CupertinoSwitch(
                                      value: controller.ocultarDireccion.value,
                                      activeColor: pink_,
                                      onChanged: (value) {
                                        controller.ocultarDireccion.value =
                                            !controller.ocultarDireccion.value;
                                      }),
                                ],
                              ),
                            )
                          ]),
                        )
                      : SizedBox(
                          child: parrafo('No cuento con dirección'),
                        )),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), color: pink_),
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () async {
                          await Get.toNamed(Routes.servicios3);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Siguiente paso',
                              style: TextStyle(
                                  // decoration: TextDecoration.underline,
                                  color: whiteTheme_,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: whiteTheme_,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget input(String texto, int length) {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(color: whiteTheme_),
      child: TextFormField(
        // autofocus: true,
        textInputAction: TextInputAction.next,
        // maxLength: length,
        decoration: InputDecoration(
          hintText: texto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
