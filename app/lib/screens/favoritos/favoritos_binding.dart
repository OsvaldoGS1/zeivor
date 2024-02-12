import 'package:app/screens/favoritos/favoritos_controller.dart';
import 'package:get/get.dart';

class FavoritosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritosController>(() => FavoritosController());
  }
}
