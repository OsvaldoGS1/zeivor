import 'package:app/config/theme.dart';
import 'package:app/widgets/footer.dart';
import 'package:app/widgets/item_menu.dart';
import 'package:app/widgets/textos.dart';
import 'package:flutter/material.dart';

class AdministradorView extends StatelessWidget {
  const AdministradorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteTheme_,
      appBar: AppBar(
        backgroundColor: whiteTheme_,
        title: titulo('Administrador'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: menuPerfil('Verificar usuarios', Icons.people),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: menuPerfil('Validar comentarios', Icons.message),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: menuPerfil('Incidentes', Icons.warning_amber),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
          decoration: const BoxDecoration(color: whiteTheme_), child: footer()),
    );
  }
}
