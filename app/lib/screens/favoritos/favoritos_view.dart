import 'package:app/config/theme.dart';
import 'package:app/helpers/api.dart';
import 'package:app/models/cliente.dart';
// import 'package:app/models/favorito.dart';
import 'package:app/routes/app_pages.dart';
// import 'package:app/models/profesionista_disponibles.dart';
// import 'package:app/screens/buscar/buscar_controller.dart';
import 'package:app/screens/favoritos/favoritos_controller.dart';
import 'package:app/widgets/estrellas.dart';
// import 'package:app/widgets/estrellas.dart';
import 'package:app/widgets/textos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritosView extends StatelessWidget {
  const FavoritosView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritosController>(
      builder: (controller) => Container(
        width: Get.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite,
                    color: pink_,
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: titulo('Favoritos')),
                ],
              ),
            ),
            SizedBox(
              child: parrafo(
                  'Hola ${controller.usuario!.nombre}, estos son trabajos favoritos de tu cuenta:'),
            ),
            Obx(
              () => controller.isloading.value
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: pink_,
                      ),
                    )
                  : controller.lista.isEmpty
                      ? Container(
                          margin: EdgeInsets.only(top: Get.height * 0.25),
                          alignment: Alignment.center,
                          child: parrafo('No hay resultados'),
                        )
                      : Flexible(
                          child: ListView.builder(
                            itemCount: controller.lista.length,
                            itemBuilder: (BuildContext context, int index) {
                              return tarjeta(
                                  controller.lista[index], controller);
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tarjeta(Cliente favorito, FavoritosController controller) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.only(bottom: Get.height * 0.09),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          child: Image.network(
            '${ApiService().ruta}${favorito.imagen}',
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
        top: 5,
        right: 10,
        child: Container(
          // alignment: Alignment.center,
          width: Get.width * 0.35,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: grey_.withOpacity(0.7),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                color: favorito.estatus == 'Activo' ? Colors.green : Colors.red,
              ),
              Text(
                " ${favorito.estatus}",
                style: const TextStyle(
                    color: blackTheme_,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          decoration: BoxDecoration(
            color: whiteTheme_,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(top: 5),
                child: Text(
                  '${favorito.profesion} ${favorito.usuario!.nombre}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
              SizedBox(
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: Get.width * 0.5,
                        height: 50,
                        child: StarRating(
                            double.parse(favorito.calificacion.toString()))),
                    Text(
                      favorito.calificacion.toString(),
                      style: const TextStyle(color: blackTheme_, fontSize: 17),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: parrafoAuto('${favorito.descripcion}'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: TextButton(
                      child: const Text(
                        'Ver Detalles',
                        style: TextStyle(
                            color: whiteTheme_,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.detalles, arguments: favorito);
                        // final con = Get.put(BuscarController());
                        // controller.irDetalles(favorito);
                      },
                    ),
                  ),
                  favorito.estatus == 'Activo'
                      ? Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: pink_,
                              borderRadius: BorderRadius.circular(5)),
                          child: TextButton(
                            child: const Text(
                              'Enviar Mensaje',
                              style: TextStyle(
                                  color: whiteTheme_,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            onPressed: () async {
                              await Get.toNamed(Routes.mensaje,
                                  arguments: favorito);
                              // controller.irMensaje(oficio);
                              // final con = Get.put(BuscarController());
                              // con.irMensaje(oficio);
                              // controller.irMensaje(favorito);
                            },
                          ),
                        )
                      : Container()
                ],
              )
            ],
          ),
        ),
      ),
    ]);
  }
}

//  Positioned(
//           right: 10,
//           top: 10,
//           child: Obx(
//             () => IconButton(
//               onPressed: () {
//                 controller.isFavorite.value = !controller.isFavorite.value;
//               },
//               icon: Icon(
//                 controller.isFavorite.value
//                     ? Icons.favorite
//                     : Icons.favorite_border,
//                 color: pink_,
//                 size: 40,
//               ),
//             ),
//           ),
//         )
