import 'package:app/config/theme.dart';
import 'package:app/models/estado.dart';
// import 'package:app/routes/app_pages.dart';
import 'package:app/screens/Inicio/registro/registro_controller.dart';
import 'package:app/widgets/footer.dart';
import 'package:app/widgets/textos.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:get/route_manager.dart';

class RegistroView extends StatelessWidget {
  const RegistroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteTheme_,
      appBar: AppBar(
        backgroundColor: whiteTheme_,
      ),
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
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Sexo: ',
                        style: TextStyle(
                            color: blackTheme_,
                            fontWeight: FontWeight.w500,
                            fontSize: 19),
                      ),
                    ),
                    Obx(
                      () => Container(
                        // width: Get.width * 0.5,
                        margin: const EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                            color: whiteTheme_,
                            borderRadius: BorderRadius.circular(5)),
                        // padding: const EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.center,

                        child: DropdownButton(
                          items: const [
                            DropdownMenuItem(
                              value: 0,
                              child: Text('Hombre'),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Text('Mujer'),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text('Otro'),
                            ),
                          ],
                          onChanged: (value) {
                            controller.identificador.value =
                                int.parse(value.toString());
                            // String selectedText = '';
                            switch (value) {
                              case 0:
                                controller.sexo.value = 'Hombre';
                                break;
                              case 1:
                                controller.sexo.value = 'Mujer';
                                break;
                              case 2:
                                controller.sexo.value = 'Otro';
                                break;
                            }
                            print(controller.sexo.value);
                            // selectedText
                          },
                          value: controller.identificador.value,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          iconSize: 30,
                          alignment: Alignment.center,
                          underline: Container(),
                          style: const TextStyle(
                              color: blackTheme_,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  controller.selectDate(context);
                },
                child: Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: blackTheme_.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      parrafo('Fecha de nacimiento:'),
                      Obx(() => parrafoAuto(controller.nacimiento.value))
                    ],
                  ),
                ),
              ),
              Obx(
                () => Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: DropdownSearch(
                    items: controller.estados.value,
                    itemAsString: (item) => item.nombre,
                    onChanged: (value) {
                      // Estado estado = value;
                      controller.estado.value = value.sId;
                      // print(estado.sId);
                    },
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                    ),
                    dropdownButtonProps: const DropdownButtonProps(
                      color: pink_,
                    ),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.center,
                      dropdownSearchDecoration: InputDecoration(
                          hintText: 'Seleccione su estado o región',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
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
              Obx(
                () => controller.acepto.isFalse
                    ? const SizedBox()
                    : Container(
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
                                          child: CircularProgressIndicator
                                              .adaptive(
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
              ),
              footer()
            ]),
          ),
        ),
      ),
    );
  }
}
