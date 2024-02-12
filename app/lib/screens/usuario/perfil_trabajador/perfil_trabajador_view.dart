import 'package:app/config/theme.dart';
import 'package:app/helpers/api.dart';
import 'package:app/screens/usuario/ofrecer_servicios/terminos/input_fromatter.dart';
import 'package:app/screens/usuario/perfil_trabajador/perfil_trabajador_controller.dart';
import 'package:app/widgets/textos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PerfilTrabajadorView extends StatelessWidget {
  const PerfilTrabajadorView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerfilTrabajadorController>(
      builder: (controller) => Scaffold(
        backgroundColor: whiteTheme_,
        appBar: AppBar(
          backgroundColor: whiteTheme_,
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: SingleChildScrollView(
            child: Obx(
              () => controller.isloading.value
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: pink_,
                      ),
                    )
                  : Column(
                      children: [
                        parrafo('Profesion:'),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(top: 20),
                          decoration: const BoxDecoration(color: whiteTheme_),
                          child: TextFormField(
                            // maxLength: 10,
                            keyboardType: TextInputType.text,
                            controller: controller.profesion,
                            textInputAction: TextInputAction.next,
                            // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              hintText: 'Profesion',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: blackTheme_,
                        ),
                        parrafo('Imagen Principal:'),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 15),
                          width: Get.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(ApiService().ruta +
                                controller.oficio!.imagen.toString()),
                          ),
                        ),
                        const Divider(
                          color: blackTheme_,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Container(
                        //   alignment: Alignment.topLeft,
                        //   margin: const EdgeInsets.only(top: 20),
                        //   child: parrafo('Imagenes de tu trabajo:'),
                        // ),
                        // const Divider(
                        //   color: blackTheme_,
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        parrafo('Descripción:'),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(top: 20),
                          decoration: const BoxDecoration(color: whiteTheme_),
                          child: TextFormField(
                            maxLength: 200,
                            maxLines: 7,
                            keyboardType: TextInputType.text,
                            controller: controller.descripcion,
                            textInputAction: TextInputAction.next,
                            // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              hintText: 'Descripcion',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: blackTheme_,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        parrafo('Celular de contacto:'),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(top: 20),
                          decoration: const BoxDecoration(color: whiteTheme_),
                          child: TextFormField(
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            controller: controller.celularContacto,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: 'Celular',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: blackTheme_,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        parrafo('Numeros de referencia:'),
                        Row(
                          children: [
                            parrafo('1:     '),
                            Flexible(
                              child: Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top: 20),
                                decoration:
                                    const BoxDecoration(color: whiteTheme_),
                                child: TextFormField(
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  controller: controller.referencia1,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    hintText: 'Referencia 1',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            parrafo('2:     '),
                            Flexible(
                              child: Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top: 20),
                                decoration:
                                    const BoxDecoration(color: whiteTheme_),
                                child: TextFormField(
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  controller: controller.referencia2,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    hintText: 'Referencia 2',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            parrafo('3:     '),
                            Flexible(
                              child: Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top: 20),
                                decoration:
                                    const BoxDecoration(color: whiteTheme_),
                                child: TextFormField(
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  controller: controller.referencia3,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    hintText: 'Referencia 3',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: blackTheme_,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        parrafo('Metodos de pago:'),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              width: Get.width * 0.5,
                              // margin: const EdgeInsets.only(right: 30),
                              child: Text(
                                '${controller.efectivo}',
                                style: const TextStyle(
                                    color: blackTheme_,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            CupertinoSwitch(
                                activeColor: pink_,
                                value: controller.isTransferencia.value,
                                onChanged: (value) {})
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width * 0.5,
                              alignment: Alignment.topLeft,
                              // margin: const EdgeInsets.only(right: 30),
                              child: Text(
                                '${controller.tarjeta}',
                                style: const TextStyle(
                                    color: blackTheme_,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            CupertinoSwitch(
                                activeColor: pink_,
                                value: controller.isTransferencia.value,
                                onChanged: (value) {})
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              width: Get.width * 0.5,
                              // margin: const EdgeInsets.only(right: 30),/
                              child: Text(
                                '${controller.transferencia}',
                                style: const TextStyle(
                                    color: blackTheme_,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            CupertinoSwitch(
                                activeColor: pink_,
                                value: controller.isTransferencia.value,
                                onChanged: (value) {})
                          ],
                        ),
                        const Divider(
                          color: blackTheme_,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        parrafo('Costo por visita:'),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: controller.montoController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                              CurrencyInputFormatter()
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              hintText: '\$0.00',
                              hintStyle: const TextStyle(
                                  color: blackTheme_,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const Divider(
                          color: blackTheme_,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        parrafo('Dirrección:'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              width: Get.width * 0.5,
                              // margin: const EdgeInsets.only(right: 30),/
                              child: const Text(
                                'Mostrar dirección',
                                style: TextStyle(
                                    color: blackTheme_,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            CupertinoSwitch(
                                activeColor: pink_,
                                value: controller.mostrarDireccion.value,
                                onChanged: (value) {})
                          ],
                        ),

                        Row(
                          children: [
                            SizedBox(
                                width: Get.width * 0.3,
                                child: parrafo('Calle:')),
                            Flexible(
                              child: Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top: 20),
                                decoration:
                                    const BoxDecoration(color: whiteTheme_),
                                child: TextFormField(
                                  // maxLength: 10,
                                  keyboardType: TextInputType.text,
                                  controller: controller.calle,
                                  textInputAction: TextInputAction.next,
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
                                  decoration: InputDecoration(
                                    hintText: 'Calle',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                                width: Get.width * 0.3,
                                child: parrafo('Colonia:')),
                            Flexible(
                              child: Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top: 20),
                                decoration:
                                    const BoxDecoration(color: whiteTheme_),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: controller.colonia,
                                  textInputAction: TextInputAction.next,
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
                                  decoration: InputDecoration(
                                    hintText: 'Colonia',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                                width: Get.width * 0.3, child: parrafo('C.P:')),
                            Flexible(
                              child: Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top: 20),
                                decoration:
                                    const BoxDecoration(color: whiteTheme_),
                                child: TextFormField(
                                  maxLength: 5,
                                  keyboardType: TextInputType.number,
                                  controller: controller.cp,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    hintText: 'C.P',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                                width: Get.width * 0.3,
                                child: parrafo('Municipio/Localidad:')),
                            Flexible(
                              child: Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top: 20),
                                decoration:
                                    const BoxDecoration(color: whiteTheme_),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: controller.municipio,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: 'Calle',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                                width: Get.width * 0.3,
                                child: parrafo('Estado/Provincia:')),
                            Flexible(
                              child: Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top: 20),
                                decoration:
                                    const BoxDecoration(color: whiteTheme_),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: controller.estado,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: 'Estado/Provincia',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                                width: Get.width * 0.3,
                                child: parrafo('País:')),
                            Flexible(
                              child: Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top: 20),
                                decoration:
                                    const BoxDecoration(color: whiteTheme_),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: controller.pais,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: 'Pais',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: blackTheme_,
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 30),
                          decoration: BoxDecoration(
                              color: pink_,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Text(
                            'Guardar Datos',
                            style: TextStyle(
                                color: whiteTheme_,
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
