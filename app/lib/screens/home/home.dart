import 'package:app/config/theme.dart';
import 'package:app/helpers/estilo_map.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  // static final LatLng _kMapCenter =
  //     LatLng(19.018255973653343, 72.84793849278007);

  // static final CameraPosition kInitialPosition =
  //     CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  @override
  Widget build(BuildContext context) {
    // GoogleMapController mapController;
    return GetBuilder<HomeController>(
      builder: (controller) => Stack(
        children: [
          Obx(
            () => controller.isloading.value
                ? Container(
                    height: Get.height,
                    color: whiteTheme_,
                    child: const Center(
                        child: CircularProgressIndicator.adaptive()))
                : Container(
                    width: Get.width,
                    height: Get.height,
                    decoration: const BoxDecoration(color: whiteTheme_),
                    child: GoogleMap(
                      initialCameraPosition: controller.kInitialPosition,
                      rotateGesturesEnabled: false,
                      scrollGesturesEnabled: false,
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      markers: {
                        Marker(
                            markerId: const MarkerId('usuario'),
                            position: controller.kMapCenter.value,
                            icon: controller.iconUser),
                        Marker(
                            markerId: const MarkerId('usuario2'),
                            position: const LatLng(
                                19.39093741169823, -99.1517400933133),
                            icon: controller.iconTrabajador),
                        Marker(
                            markerId: const MarkerId('usuario3'),
                            position: const LatLng(
                                19.39294712603326, -99.15377780060122),
                            icon: controller.iconTrabajador),
                        Marker(
                            markerId: const MarkerId('usuario4'),
                            position: const LatLng(
                                19.390817759844424, -99.15250073975406),
                            icon: controller.iconTrabajador),
                        Marker(
                            markerId: const MarkerId('usuario5'),
                            position: const LatLng(
                                19.394553258084244, -99.15206860298333),
                            icon: controller.iconTrabajador),
                      },
                      // markers: controller.markers,
                      onCameraMove: (position) {},
                      onMapCreated: (control) async {
                        controller.controladorMapa = control;
                        controller.actualizarMapa();
                        controller.controladorMapa
                            .setMapStyle(MapaEstilo().estilo);
                      },
                    ),
                  ),
          ),
          Obx(() => controller.selectIndex.value != 0
              ? Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: const BoxDecoration(color: whiteTheme_),
                )
              : const SizedBox()),
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              backgroundColor: whiteTheme_,
              leading: const SizedBox(),
              title: Center(
                child: Image.asset(
                  'assets/images/logos/Logo_Oficial_ZEIVOR_icono.png',
                  scale: 25,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.usuario, arguments: controller.ps);
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: blackTheme_,
                      size: 35,
                    ))
              ],
            ),
            backgroundColor: Colors.transparent,
            body: Obx(() => controller.pages[controller.selectIndex.value]),
            bottomNavigationBar: Obx(
              () => BottomNavigationBar(
                backgroundColor: whiteTheme_,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                    ),
                    label: 'Buscar',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,
                    ),
                    label: 'Favoritos',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.filter_list,
                    ),
                    label: 'Filtros',
                  ),
                ],
                currentIndex: controller.selectIndex.value,
                selectedItemColor: pink_,
                unselectedItemColor: Colors.black,
                onTap: (value) => controller.changeTabIndex(value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
