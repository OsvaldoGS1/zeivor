import 'package:app/helpers/api.dart';
import 'package:app/models/cliente.dart';
import 'package:app/models/oficio.dart';
import 'package:app/models/usuario.dart';
import 'package:flutter/foundation.dart';

class DatosCliente {
  Future<Cliente?> datosCliente(Usuario user) async {
    Cliente? cliente;
    try {
      ApiService apiService = ApiService();
      final response = await apiService.fetchData('cliente/obtener',
          method: Method.POST, body: {"usuario": user.sId});

      if (apiService.status == 200) {
        cliente = Cliente.fromJson(response);
      }
      return cliente;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return null;
    }
  }
}
