import 'dart:io';

import 'package:app/config/theme.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/screens/usuario/ofrecer_servicios/terminos/input_fromatter.dart';
import 'package:app/screens/usuario/ofrecer_servicios/servicios_controller.dart';
import 'package:app/widgets/textos.dart';
// import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OfrecerServiciosView extends StatelessWidget {
  const OfrecerServiciosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteTheme_,
      appBar: AppBar(
        backgroundColor: whiteTheme_,
        title: titulo('Paso 1'),
      ),
      body: GetBuilder<ServiciosController>(
        builder: (controller) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Escribe tu profesión:',
                  style: TextStyle(
                      color: blackTheme_,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(color: whiteTheme_),
                child: TextFormField(
                  maxLength: 20,
                  decoration: InputDecoration(
                    hintText: 'Profesión',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Imagen descriptiva:',
                  style: TextStyle(
                      color: blackTheme_,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(Container(
                    height: Get.height * 0.2,
                    decoration: BoxDecoration(
                        color: whiteTheme_,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        const Text(
                          'Elija una opcion:',
                          style: TextStyle(
                              color: blackTheme_,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.imagenfromGaleriaa();
                                  },
                                  child: SizedBox(
                                    width: Get.width * 0.4,
                                    child: const Column(
                                      children: [
                                        Text(
                                          'Galeria',
                                          style: TextStyle(
                                              color: blackTheme_, fontSize: 19),
                                        ),
                                        Icon(
                                          Icons.photo,
                                          size: 35,
                                          color: pink_,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.imagefromCamara();
                                  },
                                  child: SizedBox(
                                    width: Get.width * 0.4,
                                    child: const Column(
                                      children: [
                                        Text(
                                          'Camara',
                                          style: TextStyle(
                                              color: blackTheme_, fontSize: 19),
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
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: Get.width,
                  height: Get.height * 0.3,
                  decoration: BoxDecoration(
                      color: whiteTheme_,
                      border: Border.all(color: blackTheme_),
                      borderRadius: BorderRadius.circular(20)),
                  child: Obx(
                    () => controller.imagenPath.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Seleccione una imagen',
                                  style: TextStyle(color: blackTheme_),
                                ),
                                Icon(
                                  Icons.upload_file,
                                  color: blackTheme_,
                                )
                              ],
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              File('${controller.imagenPath}'),
                              scale: 1,
                              fit: BoxFit.contain,
                            ),
                          ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Descripción: ',
                  style: TextStyle(
                      color: blackTheme_,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(color: whiteTheme_),
                child: TextFormField(
                  maxLength: 200,
                  maxLines: 7,
                  controller: controller.descripcion,
                  decoration: InputDecoration(
                    hintText: 'Descripción',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Metodos de pago: ',
                  style: TextStyle(
                      color: blackTheme_,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 20),
                  width: Get.width,
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.width * 0.25,
                          child: Column(
                            children: [
                              const SizedBox(
                                  child: Text(
                                'Pago en efectivo',
                                textAlign: TextAlign.center,
                              )),
                              Checkbox.adaptive(
                                  value: controller.efectivo.value,
                                  activeColor: pink_,
                                  onChanged: (value) {
                                    controller.efectivo.value =
                                        !controller.efectivo.value;
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.3,
                          child: Column(
                            children: [
                              const SizedBox(
                                child: Text(
                                  'Pago con transferencia',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Checkbox.adaptive(
                                  value: controller.transferencia.value,
                                  activeColor: pink_,
                                  onChanged: (value) {
                                    controller.transferencia.value =
                                        !controller.transferencia.value;
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.25,
                          child: Column(
                            children: [
                              const SizedBox(
                                  child: Text(
                                'Pago en tarjeta',
                                textAlign: TextAlign.center,
                              )),
                              Checkbox.adaptive(
                                  value: controller.tarjeta.value,
                                  activeColor: pink_,
                                  onChanged: (value) {
                                    controller.tarjeta.value =
                                        !controller.tarjeta.value;
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Emite facturas: ',
                        style: TextStyle(
                            color: blackTheme_,
                            fontWeight: FontWeight.w500,
                            fontSize: 19),
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.only(left: 15),
                    //   child: Obx(
                    //     () => CupertinoSwitch(
                    //         value: false,
                    //         activeColor: pink_,
                    //         onChanged: (value) {
                    //           // controller.cobroVisita.value =
                    //           //     !controller.cobroVisita.value;
                    //         }),
                    //   ),
                    // )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Celular',
                  style: TextStyle(
                      color: blackTheme_,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(color: whiteTheme_),
                child: TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: controller.celular,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'Celular',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Numeros de refencia',
                  style: TextStyle(
                      color: blackTheme_,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(color: whiteTheme_),
                child: TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  // controller: controller.celular,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'Numero de referencia 1',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(color: whiteTheme_),
                child: TextFormField(
                  maxLength: 10,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  // controller: controller.celular,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'Numero de referencia 2',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(color: whiteTheme_),
                child: TextFormField(
                  maxLength: 10,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'Numero de referencia 3',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Costo por visita:',
                        style: TextStyle(
                            color: blackTheme_,
                            fontWeight: FontWeight.w500,
                            fontSize: 19),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Obx(
                        () => CupertinoSwitch(
                            value: controller.cobroVisita.value,
                            activeColor: pink_,
                            onChanged: (value) {
                              controller.cobroVisita.value =
                                  !controller.cobroVisita.value;
                            }),
                      ),
                    )
                  ],
                ),
              ),
              Obx(
                () => controller.cobroVisita.value
                    ? Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          // controller: controller.montoController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                            CurrencyInputFormatter()
                          ],

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                            hintText: '\$0.00',
                            hintStyle: const TextStyle(
                                color: blackTheme_,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: pink_),
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () async {
                      await Get.toNamed(Routes.servicios2);
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
            ]),
          ),
        ),
      ),
    );
  }
}
