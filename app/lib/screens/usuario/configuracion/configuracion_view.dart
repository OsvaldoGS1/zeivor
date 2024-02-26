import 'package:app/config/theme.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/screens/usuario/configuracion/configuracion_controller.dart';
import 'package:app/widgets/textos.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfiguracionView extends StatelessWidget {
  const ConfiguracionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfiguracionController>(
      builder: (controller) => Scaffold(
        backgroundColor: whiteTheme_,
        appBar: AppBar(
          backgroundColor: whiteTheme_,
        ),
        body: Container(
          width: Get.width,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: opciones('Terminos y condiciones', Icons.policy),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: opciones('Aviso de privacidad', Icons.privacy_tip),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.permisos),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: opciones(
                        'Solicitud de permisos y uso de ellos', Icons.security),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: opciones('Contacto', Icons.contact_support),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget opciones(titulo, IconData icon) {
    return ListTile(
      leading: Icon(
        icon,
        color: pink_,
        size: 33,
      ),
      title: AutoSizeText(
        titulo,
        minFontSize: 18,
        maxFontSize: 23,
        style: const TextStyle(color: blackTheme_, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
