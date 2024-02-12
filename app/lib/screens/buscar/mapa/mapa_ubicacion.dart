import 'package:app/config/theme.dart';
import 'package:app/helpers/estilo_map.dart';
import 'package:app/screens/buscar/buscar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaUbicacionView extends StatelessWidget {
  const MapaUbicacionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuscarController>(
      builder: (controller) => Scaffold(
        backgroundColor: whiteTheme_,
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/images/logos/Logo_Oficial_ZEIVOR_icono.png',
            scale: 25,
          ),
        ),
        body: SizedBox(
          // height: Get.height * 0.75,
          width: Get.width,
          child: Obx(
            () => GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                markers: <Marker>{
                  Marker(
                    markerId: const MarkerId("marker_id"),
                    position: controller.markerPosition.value,
                  ),
                },
                initialCameraPosition: CameraPosition(
                  target: controller.markerPosition.value,
                  zoom: 17.0,
                ),
                onCameraMove: (position) {
                  controller.markerPosition.value = position.target;
                  controller.polyline();
                },
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("polyline_1"),
                    color: pink_,

                    patterns: [
                      PatternItem.dot,
                      PatternItem.gap(10),
                    ],
                    // jointType: JointType.round,
                    startCap: Cap.roundCap,
                    endCap: Cap.roundCap,
                    width: 5,
                    points: controller.polylineCoordinates,
                  ),
                },
                onMapCreated: (controller) {
                  controller.setMapStyle(MapaEstilo().estilo);
                }),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GestureDetector(
            onTap: () async {
              await controller.ubicacion();
            },
            child: Container(
              width: Get.width,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, right: 10),
              height: 50,
              decoration: BoxDecoration(
                  color: pink_, borderRadius: BorderRadius.circular(10)),
              child: const Text(
                'Seleccionar Ubicación',
                style: TextStyle(
                    color: whiteTheme_,
                    fontWeight: FontWeight.bold,
                    fontSize: 21),
              ),
            )),
      ),
    );
  }
}
