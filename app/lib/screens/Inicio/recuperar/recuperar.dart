// import 'package:flutter/cupertino.dart';
import 'package:app/config/theme.dart';
import 'package:app/screens/Inicio/recuperar/recuperar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RecuperarView extends StatelessWidget {
  const RecuperarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecuperarController>(
      builder: ((controller) => Scaffold(
            backgroundColor: whiteTheme_,
            appBar: AppBar(
              backgroundColor: whiteTheme_,
              centerTitle: true,
              title: Image.asset(
                'assets/images/logos/Logo_Oficial_ZEIVOR_icono.png',
                scale: 25,
                fit: BoxFit.cover,
              ),
              elevation: 0,
            ),
            body: Obx(
              () => controller.isRecovery.value
                  ? const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator.adaptive(),
                          Text(
                            'Estamos procesando tu solicitud',
                            style: TextStyle(
                                color: blackTheme_,
                                fontFamily: 'KoHo',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          // Container(
                          //   alignment: Alignment.center,
                          //   margin: const EdgeInsets.only(bottom: 20, top: 20),
                          //   width:Get.width * 0.6,
                          //   child: Image.asset(
                          //     'assets/images/logo_esnaby_principal.png',
                          //     color: blackTheme_,
                          //   ),
                          // ),
                          Container(
                            alignment: Alignment.center,
                            width: Get.width,
                            child: const Text(
                              'Recuperar contraseña',
                              style: TextStyle(
                                  color: blackTheme_,
                                  fontFamily: 'KoHo',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            width: Get.width,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Escribe tu correo electronico y tu numero de WhatsApp para recuperar tu contraseña',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: blackTheme_,
                                    fontFamily: 'KoHo',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: whiteTheme_,
                                  borderRadius: BorderRadius.circular(20)),
                              width: Get.width,
                              // height: 60,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 15),
                              child: Center(
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: controller.emailTextController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'Correo',
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.3)),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.3)),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: whiteTheme_,
                                borderRadius: BorderRadius.circular(20)),
                            width: Get.width,
                            // height: 60,
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 15),
                            child: Center(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                controller: controller.numeroController,
                                decoration: InputDecoration(
                                  hintText: 'Numero de telefono',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.3)),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.3)),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.3),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 15),
                            width: Get.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  child: Image.asset(
                                    'assets/images/iconos/icon_chatbot.png',
                                    height: 32,
                                    width: 32,
                                  ),
                                ),
                                const Flexible(
                                  child: Text(
                                    'Nuestro Bot te hará llegar un mensaje de WhatsApp con tu contraseña',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: blackTheme_,
                                        fontFamily: 'KoHo',
                                        fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 15),
                            width: Get.width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  child: Image.asset(
                                    'assets/images/iconos/icon_email.png',
                                    height: 32,
                                    width: 32,
                                  ),
                                ),
                                const Flexible(
                                  child: Text(
                                    'Busca en tu buzón de entrada, en correos no deseados o Spam tu contraseña',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: blackTheme_,
                                        fontFamily: 'KoHo',
                                        fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                color: pink_,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 7, right: 7, top: 3, bottom: 3),
                              child: TextButton(
                                onPressed: () {
                                  // controller.recuperarContrasena();
                                },
                                child: const Text(
                                  'Solicitar',
                                  style: TextStyle(
                                      color: whiteTheme_,
                                      fontFamily: 'KoHo',
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          )),
    );
  }
}
