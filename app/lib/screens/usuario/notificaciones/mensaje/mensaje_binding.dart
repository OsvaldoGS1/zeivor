import 'package:app/screens/usuario/notificaciones/mensaje/mensaje_controller.dart';
import 'package:get/get.dart';

class MensajeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MensajeController>(() => MensajeController());
  }
}
