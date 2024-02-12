import 'package:app/config/theme.dart';
// import 'package:app/routes/app_pages.dart';
import 'package:app/screens/Inicio/registro/registro_controller.dart';
import 'package:app/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:get/route_manager.dart';

class RegistroView extends StatelessWidget {
  const RegistroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: whiteTheme_.withOpacity(0.91),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: GetBuilder<RegistroController>(
            builder: (controller) => Column(children: [
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Registrarse',
                  style: TextStyle(
                      color: blackTheme_,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  'Nombre',
                  style: TextStyle(
                      color: blackTheme_,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(color: whiteTheme_),
                child: TextField(
                  controller: controller.nombre,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: 'Nombre',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  'Apellido Paterno',
                  style: TextStyle(
                      color: blackTheme_,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(color: whiteTheme_),
                child: TextField(
                  controller: controller.apellido,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: 'Apellido Paterno',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  'Apellido Materno',
                  style: TextStyle(
                      color: blackTheme_,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(color: whiteTheme_),
                child: TextField(
                  textCapitalization: TextCapitalization.characters,
                  controller: controller.apellidoM,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Apellido Materno',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  'Celular',
                  style: TextStyle(
                      color: blackTheme_,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(color: whiteTheme_),
                child: TextFormField(
                  controller: controller.celular,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'Celular',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  'Correo',
                  style: TextStyle(
                      color: blackTheme_,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(color: whiteTheme_),
                child: TextField(
                  controller: controller.correo,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    // FilteringTextInputFormatter.allow(RegExp('[a-z@.]')),
                    FilteringTextInputFormatter.allow(RegExp('[a-z0-9@.]')),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Correo Electrónico',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Container(
                width: Get.width,
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Obx(() => Checkbox.adaptive(
                        value: controller.acepto.value,
                        onChanged: (value) {
                          controller.acepto.value = !controller.acepto.value;
                        })),
                    const Flexible(
                      child: Text(
                        '¿Aceptas los terminos y condiciones?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: blackTheme_,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: pink_,
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: const EdgeInsets.only(top: 20, bottom: 60),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () async {
                      controller.isLoading.value
                          ? null
                          : await controller.validar();
                    },
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          controller.isLoading.value
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator.adaptive(
                                    backgroundColor: whiteTheme_,
                                  ),
                                )
                              : const SizedBox(),
                          Text(
                            controller.isLoading.value
                                ? 'Registrandose'
                                : 'Registrarse',
                            style: const TextStyle(
                                color: whiteTheme_,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              footer()
            ]),
          ),
        ),
      ),
    );
  }
}
