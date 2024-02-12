import 'package:app/screens/usuario/alertas_oficio/alertas_oficio_controller.dart';
import 'package:get/get.dart';

class AlertasOficioBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AlertasOficioController());
  }
}
