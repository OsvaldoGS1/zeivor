import 'package:app/config/theme.dart';
import 'package:app/models/contrato.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:app/widgets/textos.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

Widget incidente() {
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
          child: const Text("Explica el motivo de la incidencia: ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: blackTheme_,
                  fontWeight: FontWeight.bold,
                  fontSize: 17)),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextFormField(
            maxLines: 4,
            maxLength: 100,
            decoration: InputDecoration(
              hintText: 'Situacion por la cual realizar el reporte',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        Container(
            // padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: pink_, borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.only(top: 1, left: 8, right: 8),
              child: TextButton(
                child: const Text(
                  'Reportar',
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
