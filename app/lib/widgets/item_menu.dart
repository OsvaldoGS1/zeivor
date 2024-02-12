import 'package:app/config/theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget menuPerfil(String titulo, IconData iconData) {
  return ListTile(
      leading: Icon(
        iconData,
        color: pink_,
        size: Get.width * 0.085,
      ),
      title: AutoSizeText(
        titulo,
        minFontSize: 1,
        maxFontSize: 23,
        style: const TextStyle(color: blackTheme_, fontWeight: FontWeight.bold),
      ));
}
