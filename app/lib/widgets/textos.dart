import 'package:app/config/theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

Widget titulo(String titulo) {
  return Text(
    titulo,
    style: const TextStyle(
        color: blackTheme_, fontSize: 25, fontWeight: FontWeight.bold),
  );
}

Widget tituloCenter(String titulo) {
  return Text(
    titulo,
    textAlign: TextAlign.center,
    style: const TextStyle(
        color: blackTheme_, fontSize: 25, fontWeight: FontWeight.bold),
  );
}

Widget parrafo(String texto) {
  return Text(
    texto,
    textAlign: TextAlign.start,
    style: const TextStyle(color: blackTheme_, fontSize: 18),
  );
}

Widget parrafoConfirmacion(String texto) {
  return Text(
    texto,
    textAlign: TextAlign.center,
    style: const TextStyle(color: blackTheme_, fontSize: 17),
  );
}

Widget parrafoAuto(String titulo) {
  return AutoSizeText(
    titulo,
    minFontSize: 16,
    maxLines: 3,
    textAlign: TextAlign.justify,
    overflow: TextOverflow.ellipsis,
    maxFontSize: 23,
    style: const TextStyle(
      color: blackTheme_,
    ),
  );
}

Widget parrafoAutoCenter(String titulo) {
  return AutoSizeText(
    titulo,
    minFontSize: 15,
    maxLines: 3,
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    maxFontSize: 23,
    style: const TextStyle(
      color: blackTheme_,
    ),
  );
}

Widget textoInput(String titulo) {
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(top: 20),
    child: Text(
      titulo,
      style: const TextStyle(
          color: blackTheme_, fontWeight: FontWeight.w500, fontSize: 19),
    ),
  );
}
