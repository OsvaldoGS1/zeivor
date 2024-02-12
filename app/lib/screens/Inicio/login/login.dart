import 'package:app/config/theme.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/screens/Inicio/login/login_controller.dart';
import 'package:app/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: ((controller) => Scaffold(
            body: Obx(
              () => controller.isLoading.value
                  ? Container(
                      alignment: Alignment.center,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator.adaptive(),
                          Text(
                            'Iniciando sesion',
                            style: TextStyle(color: blackTheme_, fontSize: 20),
                          )
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 60),
                            ),
                            Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(top: 20),
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    // color: whiteTheme_,
                                    borderRadius: BorderRadius.circular(75)),
                                child: Image.asset(
                                    'assets/images/logos/Logo_Oficial_ZEIVOR_vertical_principal.png')),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                'Ingresar',
                                style: TextStyle(
                                    color: blackTheme_,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                'Email',
                                style: TextStyle(
                                    color: blackTheme_,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(
                                  top: 20,
                                ),
                                decoration: const BoxDecoration(
                                  color: whiteTheme_,
                                ),
                                child: AutofillGroup(
                                  child: TextFormField(
                                    autofillHints: const [AutofillHints.email],
                                    controller: controller.correo,
                                    keyboardType: TextInputType.emailAddress,
                                    enableSuggestions: true,
                                    onEditingComplete: () {
                                      TextInput.finishAutofillContext();
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      fillColor: whiteTheme_,
                                      hintText: 'Email',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                )),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                'Contraseña',
                                style: TextStyle(
                                    color: blackTheme_,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Obx(
                              () => Container(
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 30),
                                decoration: const BoxDecoration(
                                  color: whiteTheme_,
                                ),
                                child: TextFormField(
                                  obscureText: controller.visiblePassword.value,
                                  controller: controller.contrasena,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.visiblePassword.value =
                                              !controller.visiblePassword.value;
                                        },
                                        icon: Icon(
                                            controller.visiblePassword.value
                                                ? Icons.visibility
                                                : Icons.visibility_off)),
                                    fillColor: whiteTheme_,
                                    hintText: 'Contraseña',
                                    border: OutlineInputBorder(
                                      // borderSide: const BorderSide(color: blackTheme_),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: grey_,
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextButton(
                                onPressed: () async {
                                  // await Get.offAllNamed(Routes.home);
                                  await controller.login();
                                },
                                child: const Text(
                                  'Ingresar',
                                  style: TextStyle(
                                      color: whiteTheme_,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const Divider(),
                            controller.datos.isLogged.value
                                ? Obx(
                                    () => controller.isBiometric.value
                                        ? Container(
                                            alignment: Alignment.center,
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: TextButton(
                                              onPressed: () {
                                                controller.entrar();
                                              },
                                              child: controller.acceso.value ==
                                                      'Face ID'
                                                  ? Image.asset(
                                                      'assets/images/iconos/face_id.png',
                                                      color: blackTheme_,
                                                      width: 80,
                                                    )
                                                  : const Icon(
                                                      Icons.fingerprint,
                                                      size: 80,
                                                      color: blackTheme_,
                                                    ),
                                            ),
                                          )
                                        : Container(),
                                  )
                                : const SizedBox(),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                'Ingresa con tu perfil social',
                                style: TextStyle(
                                    color: blackTheme_,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            GetPlatform.isIOS
                                ? Container(
                                    padding: const EdgeInsets.all(3),
                                    margin: const EdgeInsets.all(5),
                                    width: Get.width * 0.7,
                                    child: SignInWithAppleButton(
                                      onPressed: () async {
                                        await controller.ingresar('apple');
                                      },
                                      text: 'Iniciar sesion con Apple',
                                    ),
                                    // ElevatedButton.icon(
                                    //   onPressed: () async {
                                    //     await controller.authApple();
                                    //   },
                                    //   icon: Image.asset(
                                    //     'assets/images/iconos/apple.png',
                                    //     width: 25,
                                    //   ),
                                    //   label: const Text(
                                    //     'Iniciar sesion con Apple ID',
                                    //     textAlign: TextAlign.center,
                                    //     style: TextStyle(
                                    //         color: blackTheme_,
                                    //         fontWeight: FontWeight.bold,
                                    //         fontSize: 17),
                                    //   ),
                                    // ),
                                  )
                                : const SizedBox(),
                            // Container(
                            //   padding: const EdgeInsets.all(3),
                            //   margin: const EdgeInsets.all(5),
                            //   width: Get.width * 0.7,
                            //   child: ElevatedButton.icon(
                            //     onPressed: () async {
                            //       await controller.authFacebook();
                            //     },
                            //     icon: Image.asset(
                            //       'assets/images/iconos/facebook.png',
                            //       width: 25,
                            //     ),
                            //     label: const Text(
                            //       'Iniciar sesion con Facebook',
                            //       textAlign: TextAlign.center,
                            //       style: TextStyle(
                            //           color: blackTheme_,
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 17),
                            //     ),
                            //     style: ElevatedButton.styleFrom(
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(5),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Container(
                              padding: const EdgeInsets.all(3),
                              margin: const EdgeInsets.all(5),
                              width: Get.width * 0.7,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  await controller.ingresar('google');
                                },
                                icon: Image.asset(
                                  'assets/images/iconos/google.png',
                                  width: 25,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: whiteTheme_,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                label: const Text(
                                  'Iniciar sesion con Google',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: blackTheme_,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                            Container(
                              width: Get.width * 1,
                              margin: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await Get.toNamed(Routes.recuperar);
                                    },
                                    child: Container(
                                      width: Get.width * 0.35,
                                      alignment: Alignment.topLeft,
                                      child: const Text(
                                        '¿Olvide mi contraseña?',
                                        style: TextStyle(
                                            color: blackTheme_,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await Get.toNamed(Routes.registro);
                                    },
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      width: Get.width * 0.35,
                                      child: const Text(
                                        'Registrarse',
                                        style: TextStyle(
                                            color: blackTheme_,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            footer(),
                            // const SizedBox(
                            //   height: 50,
                            // ),
                          ],
                        ),
                      ),
                    ),
            ),
            // bottomNavigationBar: footer(),
          )),
    );
  }
}
