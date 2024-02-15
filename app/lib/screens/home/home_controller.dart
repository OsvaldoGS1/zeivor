import 'dart:ui' as ui;
// import 'package:app/config/theme.dart';
import 'package:app/helpers/api.dart';
import 'package:app/helpers/data.dart';
import 'package:app/helpers/obtener_oficio.dart';
import 'package:app/helpers/position.dart';
import 'package:app/models/oficio.dart';
// import 'package:app/helpers/position.dart';
import 'package:app/models/usuario.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/screens/buscar/buscar.dart';
import 'package:app/screens/buscar/buscar_controller.dart';
import 'package:app/screens/favoritos/favoritos_controller.dart';
import 'package:app/screens/favoritos/favoritos_view.dart';
import 'package:app/screens/filtros/filtros_controller.dart';
import 'package:app/screens/filtros/filtros_view.dart';
import 'package:app/widgets/snackbar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  RxInt selectIndex = 0.obs;
  Usuario? usuario;

  void changeTabIndex(int index) async {
    final favoritoController = Get.put(FavoritosController());

    selectIndex.value = index;
    if (index == 1) {
      await favoritoController.buscarFavoritos();
      print('si funciono');
    }
  }

  List<Widget> pages = [
    const BuscarView(),
    const FavoritosView(),
    const FiltrosView()
  ];

  // Posicion? posicionController;
  Oficio? oficio;
  @override
  void onInit() async {
    Get.put(BuscarController());
    Get.put(FavoritosController());
    Get.put(FiltrosController());
    Get.put(Posicion());

    usuario = Datos().recoveryData();
    await obtenerPosicion();
    if (usuario!.tipoUsuario == 2) {
      oficio = await DatosOficio().datosOficio(usuario!);
      if (oficio!.estatus == 'Validando') {
        snackbarOscura('Tu perfil esta en proceso de validacion', '');
      }
    }
    super.onInit();
  }

  Future obtenerUsuario() async {
    usuario = Datos().recoveryData();
  }

  RxBool isloading = false.obs;
  Position? ps;
  Placemark? lugar;
  late GoogleMapController controladorMapa;
  late CameraPosition kInitialPosition;
  RxBool tieneAcceso = false.obs;
  // RxSet<Marker> markers = <Marker>{}.obs;
  Rx<LatLng> kMapCenter = const LatLng(19.044488, -98.198593).obs;
  BitmapDescriptor iconUser = BitmapDescriptor.defaultMarker;

  List<Marker> marcadores = [];

  Future obtenerPosicion() async {
    isloading.value = true;

    try {
      Posicion posicionController = Get.find();
      tieneAcceso.value = await posicionController.obtenerPermiso();
      if (tieneAcceso.value) {
        await posicionController.obtenerPosicion();
        ps = posicionController.lugar;
        kMapCenter.value = LatLng(ps!.latitude, ps!.longitude);
        kInitialPosition = CameraPosition(
            target: kMapCenter.value, zoom: 17.0, tilt: 0, bearing: 0);
        List<Placemark> place =
            await placemarkFromCoordinates(ps!.latitude, ps!.longitude);
        lugar = place[0];
        print(place[0]);
      } else {
        Get.offAllNamed(Routes.permisoUbi);
      }
      await generarIconUsuario(kMapCenter.value);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    isloading.value = false;
  }

  void actualizarMapa() {
    Geolocator.getPositionStream().listen((position) async {
      ps = position;
      kMapCenter.value = LatLng(ps!.latitude, ps!.longitude);
      kInitialPosition = CameraPosition(
          target: kMapCenter.value, zoom: 17.0, tilt: 0, bearing: 0);
      controladorMapa
          .animateCamera(CameraUpdate.newCameraPosition(kInitialPosition));
    });
  }

  Future generarIconUsuario(LatLng position) async {
    iconUser = BitmapDescriptor.fromBytes(await assetsIcon(),
        size: const Size(10, 10));
    iconTrabajador = BitmapDescriptor.fromBytes(await assetsIconTrabajador(),
        size: const Size(10, 10));
    await generarMarcadores(position);
  }

  BitmapDescriptor iconTrabajador = BitmapDescriptor.defaultMarker;
  Future generarMarcadores(LatLng position) async {
    for (int i = 1; i <= 4; i++) {
      marcadores.add(Marker(
        markerId: MarkerId('marker$i'),
        position:
            LatLng(position.latitude + 0.20 * i, position.longitude + 0.20 * i),
        icon: iconTrabajador,
      ));
    }
  }

  Future<Uint8List> assetsIcon() async {
    String rutaImagen = '';
    if (usuario!.tipo == 'ninguno') {
      rutaImagen = '${ApiService().ruta}${usuario!.imagen}';
    } else {
      rutaImagen = usuario!.imagen ?? '';
    }
    http.Response response = await http.get(Uri.parse(rutaImagen));

    ByteData bytes;
    if (response.statusCode == 200) {
      bytes = ByteData.sublistView(Uint8List.fromList(response.bodyBytes));
    } else {
      bytes = await rootBundle.load('assets/images/logos/logo.jpg');
    }

    final Uint8List list = bytes.buffer.asUint8List();
    int width = (Get.width * 0.3).round();
    final codec = await ui.instantiateImageCodec(list, targetWidth: width);

    final frame = await codec.getNextFrame();
    final image = frame.image;

    // Redondear la imagen con borde rosa
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    double circleRadius = width / 2;
    double borderWidth = 10.0;
    final double totalSize = (circleRadius + borderWidth) * 2;

    // Dibujar círculo interior
    final paintInner = Paint()
      ..shader = ImageShader(
        image,
        TileMode.clamp,
        TileMode.clamp,
        Matrix4.identity().storage,
      );
    // final rectInner = Rect.fromCircle(
    //     center: Offset(totalSize / 2, totalSize / 2), radius: circleRadius);
    canvas.drawCircle(
        Offset(totalSize / 2, totalSize / 2), circleRadius, paintInner);

    // Dibujar borde rosa
    final paintBorder = Paint()
      ..color = Colors.pink // Puedes ajustar el color según tus preferencias
      ..style = PaintingStyle.stroke
      ..strokeWidth =
          borderWidth; // Puedes ajustar la anchura del borde según tus preferencias

    // final rectBorder = Rect.fromCircle(
    //     center: Offset(totalSize / 2, totalSize / 2), radius: circleRadius);
    canvas.drawCircle(
        Offset(totalSize / 2, totalSize / 2), circleRadius, paintBorder);

    final roundedImage = await recorder
        .endRecording()
        .toImage(totalSize.toInt(), totalSize.toInt());
    final roundedBytes =
        await roundedImage.toByteData(format: ui.ImageByteFormat.png);

    return roundedBytes!.buffer.asUint8List();
  }

  Future<Uint8List> assetsIconTrabajador() async {
    ByteData bytes =
        await rootBundle.load('assets/images/logos/icono_trabajador.png');

    int width = (Get.width * 0.27).round();
    final Uint8List list = bytes.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(list, targetWidth: width);

    final frame = await codec.getNextFrame();
    final newlist =
        await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return newlist!.buffer.asUint8List();
  }
}
