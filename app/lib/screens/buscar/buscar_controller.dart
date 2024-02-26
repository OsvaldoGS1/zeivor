import 'package:app/config/theme.dart';
import 'package:app/helpers/api.dart';
import 'package:app/helpers/data.dart';
import 'package:app/helpers/position.dart';
import 'package:app/models/cliente.dart';

import 'package:app/models/profesionista_disponibles.dart';
import 'package:app/models/usuario.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/screens/home/home_controller.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:app/widgets/textos.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class BuscarController extends GetxController {
  TextEditingController buscadorAlerta = TextEditingController();
  TextEditingController buscador = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  // Tabba

  RxString busqueda = ''.obs;

  Usuario? usuario;
  // late Posicion posicionController; //= Get.find();
  @override
  void onInit() async {
    usuario = Datos().recoveryData();
    super.onInit();
    // posicionController = Get.find();
  }

  //Confirmacion
  // RxBool hizoContacto = false.obs;
  RxString respuestaAPI = ''.obs;
  RxString respuestaAPI2 = ''.obs;
  RxBool isloading = false.obs;

  // RxList<ProfesionistasDisponibles> resultados =
  // <ProfesionistasDisponibles>[].obs;

  RxList<Cliente> resultados = <Cliente>[].obs;

  Future buscar() async {
    isloading.value = true;
    try {
      resultados.clear();
      ApiService apiService = ApiService();
      String busqueda = buscador.text;
      // String lat = '';
      // String lon = '';
      // if (ubicacionBusqueda != null) {
      //   lat = ubicacionBusqueda!.latitude.toStringAsFixed(6);
      //   lon = ubicacionBusqueda!.longitude.toStringAsFixed(6);
      // } else {
      //   Posicion posicionController = Get.find();
      //   ps = posicionController.lugar;
      //   lat = ps!.latitude.toStringAsFixed(2);
      //   lon = ps!.longitude.toStringAsFixed(2);
      // }
      final respuesta = await apiService
          .fetchData('busqueda/${usuario!.sId}/$busqueda', method: Method.GET);

      if (apiService.status == 200) {
        resultados.value = Cliente.fromJsonList(respuesta);
      } else {
        respuestaAPI2.value = respuesta['message'];
      }
      // print(respuesta);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    isloading.value = false;
  }

  ///Crear alerta

  RxBool creandoAlerta = false.obs;
  RxBool otraUbicacion = false.obs;

  Future pregunta() async {
    try {
      // print(buscadorAlerta.text);
      if (buscadorAlerta.text.isEmpty || buscadorAlerta.text.length < 3) {
        snackbar("Error", "Escriba el servicio que esta buscando");
        return;
      }
      return Get.defaultDialog(
        title: '¿El servicio es para tu ubicación actual ?',
        backgroundColor: whiteTheme_,
        content: Column(
          children: [
            GestureDetector(
              onTap: () async {
                Get.back();
                otraUbicacion.value = false;
                await crearAlerta();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: Get.width * 0.6,
                decoration: BoxDecoration(
                  color: pink_,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'Si',
                  style: TextStyle(
                      color: whiteTheme_,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Get.back();
                otraUbicacion.value = true;
                await lanzarMapa(true);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: Get.width * 0.6,
                decoration: BoxDecoration(
                  color: whiteTheme_,
                  border: Border.all(color: pink_),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'Es otra ubicacion',
                  style: TextStyle(
                      color: blackTheme_,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      );
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future crearAlerta() async {
    creandoAlerta.value = true;
    try {
      String fecha = DateTime.now().toLocal().toString();
      HomeController controlador = Get.find();
      ApiService apiService = ApiService();

      Map<String, dynamic> body = {
        "usuario": usuario!.sId,
        "trabajo": buscadorAlerta.text,
        "descripcion":
            descripcion.text.isNotEmpty ? descripcion.text : 'Sin descripcion',
        "ubicacion": !otraUbicacion.value
            ? '${controlador.ps!.latitude},${controlador.ps!.longitude}'
            : ' ${markerPosition.value.latitude},${markerPosition.value.longitude}',
        "fecha": fecha,
        "estatus": 'Activo'
      };

      final respuesta = await apiService.fetchData('alerta/crear',
          method: Method.POST, body: body);

      if (apiService.status == 200) {
        Get.back();
        Get.defaultDialog(
            title: 'Alerta',
            backgroundColor: whiteTheme_,
            content: Column(
              children: [
                parrafo(
                  respuesta['message'],
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                      color: pink_,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'Cerrar',
                      style: TextStyle(
                          color: whiteTheme_,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ));
      } else {
        respuestaAPI.value = respuesta['message'];
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    creandoAlerta.value = false;
  }

  //Detalles

  Rx<ProfesionistasDisponibles> oficio = ProfesionistasDisponibles().obs;
  RxString tarjeta = ''.obs;
  RxString transferencia = ''.obs;
  RxString efectivo = ''.obs;

  void irDetalles(ProfesionistasDisponibles profesion) {
    Get.toNamed(Routes.detalles, arguments: ['busqueda', profesion]);
  }

  //Ubicacion extra

  late GoogleMapController controladorMapa;
  late CameraPosition kInitialPosition;
  Position? ps;
  Rx<LatLng> markerPosition = const LatLng(0, 0).obs;

  Future lanzarMapa(bool isAlert) async {
    Posicion posicionController = Get.find();
    ps = posicionController.lugar;
    markerPosition.value = LatLng(ps!.latitude, ps!.longitude);
    kInitialPosition = CameraPosition(
        target: LatLng(ps!.latitude, ps!.longitude),
        zoom: 17.0,
        tilt: 0,
        bearing: 0);
    //
    esAlerta.value = isAlert;
    print(esAlerta.value);
    await Get.toNamed(Routes.mapabusqueda);
  }

  RxBool esAlerta = false.obs;
  LatLng? ubicacionBusqueda;
  Future ubicacion() async {
    Get.defaultDialog(
      title: "¿Estas seguro de esa ubicacion?",
      content: const SizedBox(),
      backgroundColor: whiteTheme_,
      buttonColor: pink_,
      textCancel: 'no',
      textConfirm: 'Si',
      onConfirm: () async {
        if (esAlerta.value) {
          Get.back();
          await crearAlerta();
        } else {
          Get.back();
          Get.back();
          ubicacionBusqueda = markerPosition.value;
          // print(markerPosition.value);
        }
      },
    );
    // await crearAlerta();
  }

  List<LatLng> polylineCoordinates = [];
  void polyline() {
    polylineCoordinates.clear();
    polylineCoordinates.add(LatLng(ps!.latitude, ps!.longitude));
    polylineCoordinates.add(markerPosition.value);
  }
}
