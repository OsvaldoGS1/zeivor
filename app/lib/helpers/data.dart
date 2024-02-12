import 'package:app/models/usuario.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Datos with CacheManager {
  // final box = GetStorage();
  RxBool isLogged = false.obs;

  void logOut() {
    removeUser();
    isLogged.value = false;
  }

  Future login(Map<String, dynamic> user) async {
    isLogged.value = true;
    await guardarUsuario(user);
  }

  Usuario recoveryData() {
    Usuario user = getUser();
    return user;
  }

  bool checkLogin() {
    Usuario user = recoveryData();
    if (user.correo!.isNotEmpty) {
      isLogged.value = true;
      return true;
    } else {
      isLogged.value = false;
      return false;
    }
  }
}

mixin CacheManager {
  Future<bool> guardarUsuario(Map<String, dynamic> user) async {
    final box = GetStorage();
    await box.write('usuario', user);
    getUser();
    return true;
  }

  Usuario getUser() {
    final box = GetStorage();
    Usuario user = Usuario();
    if (box.read('usuario') != null) {
      user = Usuario.fromJson(box.read('usuario'));
    }
    return user;
  }

  Future<void> removeUser() async {
    final box = GetStorage();
    await box.remove('usuario');
  }
}
