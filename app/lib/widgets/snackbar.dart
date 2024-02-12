import 'package:app/config/theme.dart';
import 'package:get/get.dart';

Future snackbar(titulo, mensaje) async {
  return Get.snackbar(titulo, mensaje,
      colorText: blackTheme_, backgroundColor: whiteTheme_);
}

Future snackbarOscura(titulo, mensaje) async {
  return Get.snackbar(titulo, mensaje,
      colorText: whiteTheme_, backgroundColor: blackTheme_);
}
