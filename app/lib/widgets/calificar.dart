import 'package:app/config/theme.dart';
import 'package:app/models/contrato.dart';
import 'package:app/models/oferta.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

Widget calificar(Contrato contrato) {
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
          child: Column(
            children: [
              Text("¿Como estuvo el servicio de ${contrato.nombre}?",
                  style: const TextStyle(
                      color: blackTheme_,
                      fontWeight: FontWeight.bold,
                      fontSize: 17)),
              Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: RatingBar.builder(
                      itemCount: 5,
                      allowHalfRating: true,
                      updateOnDrag: true,
                      itemBuilder: ((context, index) => const Icon(
                            Icons.star,
                            color: pink_,
                          )),
                      onRatingUpdate: (update) {
                        // print(update);
                      })),
            ],
          ),
        ),
        Container(
          // decoration: const BoxDecoration(color: whiteTheme_),
          margin: const EdgeInsets.all(5),
          child: TextFormField(
            maxLines: 4,
            maxLength: 100,
            decoration: InputDecoration(
              hintText: 'Opinion (opcional)',
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
                  'Calificar',
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

Widget calificarCliente(Oferta oferta) {
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
          child: Column(
            children: [
              Text(
                  "¿Califica tu experiencia en este trabajo ? Nombre del cliente: ${oferta.nombre}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: blackTheme_,
                      fontWeight: FontWeight.bold,
                      fontSize: 17)),
              Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: RatingBar.builder(
                      itemCount: 5,
                      allowHalfRating: true,
                      updateOnDrag: true,
                      itemBuilder: ((context, index) => const Icon(
                            Icons.star,
                            color: pink_,
                          )),
                      onRatingUpdate: (update) {
                        // print(update);
                      })),
            ],
          ),
        ),
        Container(
          // decoration: const BoxDecoration(color: whiteTheme_),
          margin: const EdgeInsets.all(5),
          child: TextFormField(
            maxLines: 4,
            maxLength: 100,
            decoration: InputDecoration(
              hintText: 'Opinion (opcional)',
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
                  'Calificar',
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
