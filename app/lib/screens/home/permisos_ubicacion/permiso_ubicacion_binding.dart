import 'package:app/screens/home/permisos_ubicacion/permiso_ubicacion_controller.dart';
import 'package:get/get.dart';

class PermisoUbicacionBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => PermisoUbicacionController());
  }
}
