import 'package:app/screens/usuario/notificaciones/notificaciones_controller.dart';
import 'package:get/get.dart';

class NotificacionesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificacionesController>(() => NotificacionesController());
  }
}
