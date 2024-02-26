import 'package:app/helpers/api.dart';
import 'package:app/models/oferta.dart';
import 'package:app/models/solicitud.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class UbicacionController extends GetxController {
  Solicitud oferta = Get.arguments;
  CameraPosition? initialCameraPosition;
  List coordenadas = [];
  LatLng? posicion;
  @override
  void onInit() async {
    coordenadas = oferta.localizacion!.split(',');
    //  coordenadas.add(value) =  coor.map((e) => return double.parse(e));
    // coordenadas.add(coor.map((e) {return var cor= double.parse(e));});
    // print(coordenadas);/
    initialCameraPosition = CameraPosition(
        target:
            LatLng(double.parse(coordenadas[0]), double.parse(coordenadas[1])),
        zoom: 17);

    posicion =
        LatLng(double.parse(coordenadas[0]), double.parse(coordenadas[1]));

    await ubicacion(double.parse(coordenadas[0]), double.parse(coordenadas[1]));
    super.onInit();
  }

  RxBool verMapa = false.obs;

  Placemark? lugar;
  List<LatLng> rutaCoordenadas = <LatLng>[].obs;

  Future ubicacion(lat, lon) async {
    List<Placemark> place = await placemarkFromCoordinates(lat, lon);
    lugar = place[0];
  }

  List<AvailableMap> appmaps = [];

  Future metodo() async {
    appmaps = await MapLauncher.installedMaps;
  }

  Future launchMapa(AvailableMap map) async {
    await map.showMarker(
      coords: Coords(posicion!.latitude, posicion!.longitude),
      title: '${oferta.solicitante!.nombre}',
    );
  }

  Future launchPhone(String phone) async {
    String telephoneNumber = '+526692120410';
    String telephoneUrl = "tel:$telephoneNumber";

    if (await launchUrl(Uri.parse(telephoneUrl))) {
    } else {
      throw "Error occured trying to call that number.";
    }
  }

  Future launcEmail() async {
    var emailAdress = 'mailto:smith@example.org?subject=News';
    if (!await launchUrl(Uri.parse(emailAdress))) {}
  }

  Future terminarTrabajo() async {
    try {
      ApiService apiService = ApiService();
      Map<String, dynamic> body = {"contrato": oferta.sId};

      final respuesta = await apiService.fetchData(
          'contratos/aceptar/trabajador',
          method: Method.POST,
          body: body);

      if (apiService.status == 200) {
        Get.back();
        Get.back();
        snackbar(respuesta['message'], '');
      } else {
        snackbar('Error', respuesta['message']);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
}
