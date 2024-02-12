import 'package:app/screens/usuario/ofrecer_servicios/servicios_controller.dart';
import 'package:get/get.dart';

class ServiciosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiciosController());
  }
}
