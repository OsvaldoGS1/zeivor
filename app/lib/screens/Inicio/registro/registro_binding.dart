import 'package:app/screens/Inicio/registro/registro_controller.dart';
import 'package:get/get.dart';

class RegistroBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<RegistroController>(() => RegistroController());
  }
}
