import 'package:app/config/theme.dart';
// import 'package:app/helpers/api.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/screens/usuario/usuario_controller.dart';
import 'package:app/widgets/cerrar_sesion.dart';
import 'package:app/widgets/footer.dart';
import 'package:app/widgets/item_menu.dart';
import 'package:app/widgets/textos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsuarioView extends StatelessWidget {
  const UsuarioView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UsuarioController());

    return Scaffold(
      backgroundColor: whiteTheme_,
      appBar: AppBar(
        backgroundColor: whiteTheme_,
        actions: [
          IconButton(
              onPressed: () async {
                await cerrarSesion();
                // Get.offAllNamed(Routes.login);
              },
              icon: const Icon(
                Icons.power_settings_new,
                color: blackTheme_,
                size: 30,
              ))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        width: Get.width,
        child: SingleChildScrollView(
          child: Obx(
            () => controller.isloading.value
                ? const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: pink_,
                    ),
                  )
                : Column(children: [
                    Stack(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: Image.network(
                              controller.imagenPath.value,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  // La imagen se cargó correctamente
                                  return child;
                                } else if (loadingProgress
                                        .cumulativeBytesLoaded ==
                                    loadingProgress.expectedTotalBytes) {
                                  // Error al cargar la imagen
                                  return Image.asset(
                                      'assets/images/logos/Logo_Oficial_ZEIVOR_icono.png');
                                } else {
                                  // La imagen todavía se está cargando, puedes mostrar un indicador de carga si lo deseas
                                  return const CircularProgressIndicator
                                      .adaptive(
                                    backgroundColor: pink_,
                                  );
                                }
                              },
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                // Error al cargar la imagen
                                return Image.asset(
                                  'assets/images/logos/Logo_Oficial_ZEIVOR_icono.png',
                                  scale: 7,
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: blackTheme_,
                                  borderRadius: BorderRadius.circular(50)),
                              child: IconButton(
                                  onPressed: () {
                                    // controller.imagefromCamara();
                                    Get.bottomSheet(Container(
                                      height: Get.height * 0.2,
                                      decoration: BoxDecoration(
                                          color: whiteTheme_,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Elija una opcion:',
                                            style: TextStyle(
                                                color: blackTheme_,
                                                fontSize: 21,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller
                                                          .imagenfromGaleriaa();
                                                    },
                                                    child: SizedBox(
                                                      width: Get.width * 0.4,
                                                      child: const Column(
                                                        children: [
                                                          Text(
                                                            'Galeria',
                                                            style: TextStyle(
                                                                color:
                                                                    blackTheme_,
                                                                fontSize: 19),
                                                          ),
                                                          Icon(
                                                            Icons.photo,
                                                            size: 35,
                                                            color: pink_,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller
                                                          .imagefromCamara();
                                                    },
                                                    child: SizedBox(
                                                      width: Get.width * 0.4,
                                                      child: const Column(
                                                        children: [
                                                          Text(
                                                            'Camara',
                                                            style: TextStyle(
                                                                color:
                                                                    blackTheme_,
                                                                fontSize: 19),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .camera_alt_outlined,
                                                            size: 35,
                                                            color: pink_,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                          )
                                        ],
                                      ),
                                    ));
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: pink_,
                                  )),
                            ))
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${controller.usuario!.nombre}'.toUpperCase(),
                        style:
                            const TextStyle(color: blackTheme_, fontSize: 20),
                      ),
                    ),
                    controller.usuario!.tipoUsuario == 2 &&
                            controller.oficio!.estatus != 'Validando'
                        ? GestureDetector(
                            onTap: () async {
                              if (controller.estatus.value) {
                                Get.defaultDialog(
                                  title: 'Estatus',
                                  backgroundColor: whiteTheme_,
                                  content: SizedBox(
                                    child: Column(
                                      children: [
                                        parrafo(
                                            '¿Estas seguro de cambiar tu estatus a inactivo?, con tu estatus inactivo no podras recibir ofertas de trabajo.'),
                                      ],
                                    ),
                                  ),
                                  buttonColor: pink_,
                                  textConfirm: 'Confirmar',
                                  textCancel: 'Cancelar',
                                  onConfirm: () async {
                                    Get.back();
                                    await controller.cambiarEstatus();
                                  },
                                );
                              } else {
                                await controller.cambiarEstatus();
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: Get.width * 0.35,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: grey_.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Obx(
                                () => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: controller.estatus.value
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    Flexible(
                                      child: Text(
                                        controller.estatus.value
                                            ? 'Activo'
                                            : 'Inactivo',
                                        style: const TextStyle(
                                            color: blackTheme_,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const Divider(
                      color: blackTheme_,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.informacionPersonal,
                            arguments: controller.usuario);
                      },
                      child: SizedBox(
                        width: Get.width,
                        child: menuPerfil('Información personal', Icons.person),
                      ),
                    ),
                    const Divider(
                      color: blackTheme_,
                    ),
                    controller.usuario!.tipoUsuario == 2 &&
                            controller.oficio!.estatus != 'Validando'
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.notificacion,
                                  );
                                },
                                child: SizedBox(
                                  width: Get.width,
                                  child: menuPerfil(
                                      'Notificaciones', Icons.notifications),
                                ),
                              ),
                              const Divider(
                                color: blackTheme_,
                              ),
                            ],
                          )
                        : const SizedBox(),

                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.alerta);
                      },
                      child: SizedBox(
                        width: Get.width,
                        child: menuPerfil('Mis Alertas', Icons.alarm),
                      ),
                    ),
                    const Divider(
                      color: blackTheme_,
                    ),

                    controller.usuario!.tipoUsuario == 2 &&
                            controller.oficio!.estatus != 'Validando'
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.alertaOficio);
                                },
                                child: SizedBox(
                                  width: Get.width,
                                  child: menuPerfil(
                                      'Alertas para mi', Icons.alarm),
                                ),
                              ),
                              const Divider(
                                color: blackTheme_,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.contratacion);
                      },
                      child: SizedBox(
                        width: Get.width,
                        child: menuPerfil('Mis contrataciones', Icons.language),
                      ),
                    ),
                    const Divider(
                      color: blackTheme_,
                    ),
                    // SizedBox(
                    //   width: Get.width,
                    //   child: menuPerfil('Favoritos', Icons.favorite),
                    // ),
                    // const Divider(
                    //   color: blackTheme_,
                    // ),
                    controller.usuario!.tipoUsuario == 1
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.servicios);
                                },
                                child: SizedBox(
                                  width: Get.width,
                                  child: menuPerfil(
                                      'Ofrecer mis servicios', Icons.work),
                                ),
                              ),
                              const Divider(
                                color: blackTheme_,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    controller.usuario!.tipoUsuario == 2 &&
                            controller.oficio!.estatus != 'Validando'
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await Get.toNamed(Routes.perfilTrabajador);
                                },
                                child: SizedBox(
                                  width: Get.width,
                                  child: menuPerfil('Mi perfil de trabajador',
                                      Icons.engineering),
                                ),
                              ),
                              const Divider(
                                color: blackTheme_,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    GestureDetector(
                      onTap: () async {
                        await Get.toNamed(Routes.configuracion);
                      },
                      child: SizedBox(
                        width: Get.width,
                        child: menuPerfil('Configuración', Icons.settings),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 50), child: footer())
                  ]),
          ),
        ),
      ),
      // bottomNavigationBar: footer(),
    );
  }
}
