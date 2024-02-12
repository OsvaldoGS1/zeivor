import 'package:app/helpers/api.dart';
import 'package:app/models/oficio.dart';
import 'package:app/models/usuario.dart';
import 'package:flutter/foundation.dart';

class DatosOficio {
  Future<Oficio?> datosOficio(Usuario user) async {
    Oficio? oficio;
    try {
      ApiService apiService = ApiService();
      final response = await apiService.fetchData('profesionista/obtener',
          method: Method.POST, body: {"usuario": user.idUsuario});
      if (apiService.status == 200) {
        oficio = Oficio.fromJson(response[0]);
      }
      return oficio;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return null;
    }
  }
}
