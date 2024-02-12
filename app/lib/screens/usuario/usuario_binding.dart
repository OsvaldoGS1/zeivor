import 'package:app/screens/usuario/usuario_controller.dart';
import 'package:get/get.dart';

class UsuarioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsuarioController>(() => UsuarioController());
  }
}
