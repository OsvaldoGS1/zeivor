import 'package:app/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget footer() {
  return Container(
    width: Get.width,
    margin: const EdgeInsets.all(1),
    height: 100,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logos/Logo_Oficial_ZEIVOR_vertical_principal.png',
              width: 30,
              // color: Colors.grey,
            ),
            // Image.asset(
            //   'assets/images/icono_psd_green-01.png',
            //   scale: 0.8,
            //   color: Colors.grey,
            // )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text.rich(
            TextSpan(children: [
              TextSpan(text: '© ${DateTime.now().year}'),
              const TextSpan(
                  text: ' SEIVOR',
                  style: TextStyle(
                      color: blackTheme_,
                      fontWeight: FontWeight.w700,
                      fontSize: 17)),
              const TextSpan(text: ' | Aviso de Privacidad'),
            ]),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
