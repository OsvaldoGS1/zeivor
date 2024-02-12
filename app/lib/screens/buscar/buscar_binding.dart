import 'package:app/screens/buscar/buscar_controller.dart';
import 'package:get/get.dart';

class BuscarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuscarController>(() => BuscarController());
  }
}
