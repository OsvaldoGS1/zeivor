import 'package:app/screens/usuario/informacion_personal/informacion_controller.dart';
import 'package:get/instance_manager.dart';

class InformacionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InformacionController>(() => InformacionController());
  }
}
