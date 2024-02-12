import 'package:app/screens/administrador/administrador_controller.dart';
import 'package:get/get.dart';

class AdministradorBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AdministradorController>(() => AdministradorController());
  }
}
