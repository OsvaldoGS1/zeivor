import 'package:app/config/theme.dart';
import 'package:app/helpers/formatos.dart';
import 'package:app/models/opiniones_trabajador.dart';
import 'package:app/widgets/estrellas.dart';
import 'package:flutter/material.dart';

Widget opinion(OpinionTrabajador opinion) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: whiteTheme_, borderRadius: BorderRadius.circular(15)),
    child: Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            '${opinion.nombre}',
            style: const TextStyle(
                color: blackTheme_, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          // width: Get.width * 0.6,
          // height: 50,
          child: Row(
            children: [
              StarRating(
                double.parse(opinion.calificacion.toString()),
              ),
              Flexible(
                  child: Text('  (${opinion.calificacion!.substring(0, 3)})'))
            ],
          ),
        ),
        const Divider(),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            '${opinion.mensaje}',
            style: const TextStyle(
                color: blackTheme_, fontWeight: FontWeight.normal),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            Formato().formatingDate(opinion.fecha.toString()).toUpperCase(),
            style: const TextStyle(
                color: blackTheme_, fontWeight: FontWeight.normal),
          ),
        ),
      ],
    ),
  );
}
