import 'package:app/screens/Inicio/login/auth/auth_controller.dart';
import 'package:get/get.dart';

class AuthSocialBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthSocialController());
  }
}
