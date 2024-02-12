import 'package:app/screens/usuario/perfil_trabajador/perfil_trabajador_controller.dart';
import 'package:get/get.dart';

class PerfilTrabajadorBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => PerfilTrabajadorController());
  }
}
