import 'package:app/screens/Inicio/recuperar/recuperar_controller.dart';
import 'package:get/get.dart';

class RecuperarBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => RecuperarController());
  }
}
