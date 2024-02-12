import 'package:app/config/theme.dart';
import 'package:app/models/contrato.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:app/widgets/textos.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

Widget cancelar(id) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 5),
          width: Get.width * 0.3,
          height: 8,
          decoration: BoxDecoration(
              color: blackTheme_, borderRadius: BorderRadius.circular(20)),
        ),
        Container(
          alignment: Alignment.center,
          // height: 100,
          margin: const EdgeInsets.only(top: 20),
          width: Get.width,
          child: const Text(
              "¿Cuentanos el motivo de porque deseas cancelar el servicio",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: blackTheme_,
                  fontWeight: FontWeight.bold,
                  fontSize: 17)),
        ),
        // Container(
        //   // decoration: const BoxDecoration(color: whiteTheme_),
        //   margin: const EdgeInsets.all(5),
        //   child: TextFormField(
        //     maxLines: 4,
        //     maxLength: 100,
        //     decoration: InputDecoration(
        //       hintText: 'Opinion (opcional)',
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(5),
        //       ),
        //     ),
        //   ),
        // ),
        button(id),
        Container(
            // padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom: 40),
            decoration: BoxDecoration(
                color: pink_, borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.only(top: 1, left: 8, right: 8),
              child: TextButton(
                child: const Text(
                  'Terminar cancelacion',
                  style: TextStyle(
                      color: whiteTheme_,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  Get.back();
                  await snackbar('Calificacion', 'completa');
                },
              ),
            ))
      ],
    ),
  );
}

Widget button(id) {
  RxBool otro = false.obs;
  return Container(
      width: Get.width,
      // decoration: BoxDecoration(color: ),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          id == 1
              ? CustomRadioButton(
                  enableShape: true,
                  buttonTextStyle: const ButtonTextStyle(
                    selectedColor: whiteTheme_,
                    unSelectedColor: blackTheme_,
                    textStyle: TextStyle(
                      fontSize: 18,
                    ),
                    selectedTextStyle: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  spacing: 0,
                  horizontal: true,
                  padding: 5,
                  buttonValues: const [
                    "Precio demasiado alto",
                    "Error al solicitar el trabajo",
                    "El trabajador no llego",
                    "Otro"
                  ],
                  buttonLables: const [
                    "Precio demasiado alto",
                    "Error al solicitar el trabajo",
                    "El trabajador no llego",
                    "Otro motivo"
                  ],
                  radioButtonValue: (value) {
                    print(value);
                    if (value == 'Otro') {
                      otro.value = true;
                    } else {
                      otro.value = false;
                    }
                  },
                  selectedColor: pink_,
                  unSelectedColor: whiteTheme_)
              : CustomRadioButton(
                  enableShape: true,
                  buttonTextStyle: const ButtonTextStyle(
                    selectedColor: whiteTheme_,
                    unSelectedColor: blackTheme_,
                    textStyle: TextStyle(
                      fontSize: 18,
                    ),
                    selectedTextStyle: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  spacing: 0,
                  horizontal: true,
                  padding: 5,
                  buttonValues: const [
                    "No acepto el trabajo el cliente",
                    "Error al aceptar el trabajo",
                    "Domicilio incorrecto",
                    "Cliente no contesta",
                    "Otro"
                  ],
                  buttonLables: const [
                    "No acepto el trabajo el cliente",
                    "Error al aceptar el trabajo",
                    "Domicilio incorrecto",
                    "Cliente no contesta",
                    "Otro motivo"
                  ],
                  radioButtonValue: (value) {
                    print(value);
                    if (value == 'Otro') {
                      otro.value = true;
                    } else {
                      otro.value = false;
                    }
                  },
                  selectedColor: pink_,
                  unSelectedColor: whiteTheme_),
          Obx(() => otro.value
              ? Container(
                  margin: const EdgeInsets.all(5),
                  child: TextFormField(
                    maxLines: 4,
                    maxLength: 100,
                    decoration: InputDecoration(
                      hintText: 'Motivo por la cancelacion',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                )
              : const SizedBox())
        ],
      ));
}
