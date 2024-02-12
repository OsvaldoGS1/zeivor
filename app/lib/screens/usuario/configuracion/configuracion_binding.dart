import 'package:app/screens/usuario/configuracion/configuracion_controller.dart';
import 'package:get/get.dart';

class ConfiguracionBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => ConfiguracionController());
  }
}
