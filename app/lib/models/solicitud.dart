import 'package:app/models/cliente.dart';
import 'package:app/models/usuario.dart';

class Solicitud {
  String? sId;
  Cliente? cliente;
  Usuario? solicitante;
  String? fecha;
  String? mensaje;
  String? localizacion;
  String? estatusCliente;
  String? estatusSolicitante;
  String? estatus;
  int? iV;

  Solicitud(
      {this.sId,
      this.cliente,
      this.solicitante,
      this.fecha,
      this.mensaje,
      this.localizacion,
      this.estatusCliente,
      this.estatusSolicitante,
      this.estatus,
      this.iV});

  Solicitud.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cliente =
        json['cliente'] != null ? Cliente.fromJson(json['cliente']) : null;
    solicitante = json['solicitante'] != null
        ? Usuario.fromJson(json['solicitante'])
        : null;
    fecha = json['fecha'];
    mensaje = json['mensaje'];
    localizacion = json['localizacion'];
    estatusCliente = json['estatusCliente'];
    estatusSolicitante = json['estatusSolicitante'];
    estatus = json['estatus'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (cliente != null) {
      data['cliente'] = cliente!.toJson();
    }
    if (solicitante != null) {
      data['solicitante'] = solicitante!.toJson();
    }
    data['fecha'] = fecha;
    data['mensaje'] = mensaje;
    data['localizacion'] = localizacion;
    data['estatusCliente'] = estatusCliente;
    data['estatusSolicitante'] = estatusSolicitante;
    data['estatus'] = estatus;
    data['__v'] = iV;
    return data;
  }

  static List<Solicitud> fromJsonList(List list) {
    return list.map((e) => Solicitud.fromJson(e)).toList();
  }
}
