import 'package:app/screens/usuario/ofrecer_servicios/pagos/pagos_controller.dart';
import 'package:get/get.dart';

class PagosBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<PagosController>(() => PagosController());
  }
}
