import 'package:app/screens/usuario/alertas/alerta_controller.dart';
import 'package:get/get.dart';

class AlertaBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AlertaController>(() => AlertaController());
  }
}
