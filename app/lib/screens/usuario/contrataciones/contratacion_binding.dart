import 'package:app/screens/usuario/contrataciones/contratacion_controller.dart';
import 'package:get/get.dart';

class ContratacionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContratacionController>(() => ContratacionController());
  }
}
