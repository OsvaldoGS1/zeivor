import 'package:app/screens/filtros/filtros_controller.dart';
import 'package:get/instance_manager.dart';

class FiltrosBindging extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FiltrosController>(() => FiltrosController());
  }
}
