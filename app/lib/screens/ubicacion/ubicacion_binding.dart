import 'package:app/screens/ubicacion/ubicacion_controller.dart';
import 'package:get/get.dart';

class UbicacionBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => UbicacionController());
  }
}
