import 'package:app/config/theme.dart';
import 'package:app/widgets/textos.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PermisosView extends StatelessWidget {
  const PermisosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titulo('Permisos'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(20),
              color: whiteTheme_,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: pink_,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 10),
                        child: const AutoSizeText(
                          'Ubicacion',
                          minFontSize: 18,
                          maxFontSize: 23,
                          style: TextStyle(
                              color: blackTheme_, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: const AutoSizeText(
                      'Para mejorar tu experiencia y brindarte servicios personalizados, necesitamos acceder a la ubicación de tu dispositivo. La ubicación se utiliza para proporcionar los servicios mas cercanos a su ubicacion',
                      minFontSize: 18,
                      maxFontSize: 23,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: blackTheme_, fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              color: whiteTheme_,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.camera_alt,
                        color: pink_,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 10),
                        child: const AutoSizeText(
                          'Camara',
                          minFontSize: 18,
                          maxFontSize: 23,
                          style: TextStyle(
                              color: blackTheme_, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: const AutoSizeText(
                      'Se necesita el acceso a la camara del dispositivo para tomar fotografias que se utilizan para imagen de perfil y en caso de ofrecer servicios tener una imagen descriptiva',
                      minFontSize: 18,
                      maxFontSize: 23,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: blackTheme_, fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              color: whiteTheme_,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.fingerprint,
                        color: pink_,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 10),
                        child: const AutoSizeText(
                          'Biometricos',
                          minFontSize: 18,
                          maxFontSize: 23,
                          style: TextStyle(
                              color: blackTheme_, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: const AutoSizeText(
                      'Se hace uso de los biometricos del dispositivo solo para acceder mas rapido el inicio de sesion.',
                      minFontSize: 18,
                      maxFontSize: 23,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: blackTheme_, fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
