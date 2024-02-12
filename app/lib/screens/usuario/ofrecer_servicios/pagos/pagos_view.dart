import 'package:app/screens/usuario/ofrecer_servicios/pagos/pagos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class PagosView extends StatelessWidget {
  const PagosView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PagosController>(
      builder: (controlller) => Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
