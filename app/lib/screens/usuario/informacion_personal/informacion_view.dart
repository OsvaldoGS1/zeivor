import 'package:app/config/theme.dart';
import 'package:app/screens/usuario/informacion_personal/informacion_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class InformacionView extends StatelessWidget {
  const InformacionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información Personal'),
        elevation: 0,
      ),
      body: GetBuilder<InformacionController>(
        builder: (controller) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: input('Nombre', controller.nombre, false)),
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child:
                        input('Apellido Paterno', controller.apellido, false)),
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child:
                        input('Apellido Materno', controller.apellidoM, false)),
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child:
                        input('Correo electronico', controller.correo, true)),

                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Container(
                          // margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Telefono:',
                            style: TextStyle(
                                color: blackTheme_,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                          child: TextFormField(
                        controller: controller.telefono,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          hintText: 'Telefono',
                        ),
                      ))
                    ],
                  ),
                ),
                // Container(
                //     margin: const EdgeInsets.only(bottom: 10),
                //     child: input('Contraseña', controller.password)),
                controller.usuario.tipo == 'ninguno'
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            Container(
                                // margin: const EdgeInsets.only(bottom: 10),
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Contraseña:',
                                  style: TextStyle(
                                      color: blackTheme_,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                )),
                            Obx(
                              () => SizedBox(
                                  child: TextFormField(
                                controller: controller.password,
                                obscureText: controller.isPass.value,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.isPass.value =
                                            !controller.isPass.value;
                                      },
                                      icon: Icon(controller.isPass.value
                                          ? Icons.visibility
                                          : Icons.visibility_off)),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  hintText: 'Contraseña',
                                ),
                              )),
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: pink_, borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Actualizar datos',
                        style: TextStyle(
                            color: whiteTheme_,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget input(
      String titulo, TextEditingController controlador, bool isCorreo) {
    return Column(
      children: [
        Container(
            // margin: const EdgeInsets.only(bottom: 10),
            alignment: Alignment.topLeft,
            child: Text(
              '$titulo:',
              style: const TextStyle(
                  color: blackTheme_,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            )),
        SizedBox(
            child: TextFormField(
          controller: controlador,
          enabled: !isCorreo,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            hintText: titulo,
          ),
        ))
      ],
    );
  }
}
