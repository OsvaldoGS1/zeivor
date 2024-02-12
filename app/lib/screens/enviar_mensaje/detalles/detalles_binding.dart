import 'package:app/screens/enviar_mensaje/detalles/detalles_controller.dart';
import 'package:get/get.dart';

class DetallesBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DetallesController>(() => DetallesController());
  }
}
