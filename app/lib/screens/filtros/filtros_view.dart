import 'package:app/config/theme.dart';
import 'package:app/screens/filtros/filtros_controller.dart';
import 'package:app/widgets/textos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FiltrosView extends StatelessWidget {
  const FiltrosView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FiltrosController>(
      builder: (controller) => Container(
        width: Get.width,
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: titulo('Filtros'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: Get.width * 0.6,
                      child: parrafo(
                          'Busqueda de solicitud a mas de 3 km de su ubicacion')),
                  Obx(
                    () => CupertinoSwitch(
                      value: controller.mas3Km.value,
                      activeColor: pink_,
                      onChanged: (value) {
                        controller.mas3Km.value = !controller.mas3Km.value;
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: Get.width * 0.6,
                      child: parrafo(
                          'Solo trabajadores con mas de 4.5 de calificacion')),
                  Obx(
                    () => CupertinoSwitch(
                      value: controller.calificacion.value,
                      activeColor: pink_,
                      onChanged: (value) {
                        controller.calificacion.value =
                            !controller.calificacion.value;
                      },
                    ),
                  )
                ],
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.only(top: 15),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Container(
            //         margin: const EdgeInsets.only(right: 10),
            //         width: Get.width,
            //         child: parrafo('Solo trabajadores con años de experiencia'),
            //       ),
            //       LinearProgressIndicator(
            //         value: 0.2,
            //       )
            //     ],
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.only(top: 60),
              width: Get.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: blackTheme_.withOpacity(0.75),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.warning,
                      color: whiteTheme_,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: Text(
                        'Cualquier modificacion de estos filtros afectara los resultados de busqueda.',
                        style: TextStyle(
                            color: whiteTheme_, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: pink_, borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                      color: whiteTheme_,
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
