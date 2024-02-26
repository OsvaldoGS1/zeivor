class Opinion {
  Reporte? reporte;
  String? sId;
  String? cliente;
  String? solicitante;
  String? mensaje;
  double? calificacion;
  String? fecha;
  String? tipo;
  String? estatus;
  int? iV;

  Opinion(
      {this.reporte,
      this.sId,
      this.cliente,
      this.solicitante,
      this.mensaje,
      this.calificacion,
      this.fecha,
      this.tipo,
      this.estatus,
      this.iV});

  Opinion.fromJson(Map<String, dynamic> json) {
    reporte =
        json['reporte'] != null ? Reporte.fromJson(json['reporte']) : null;
    sId = json['_id'];
    cliente = json['cliente'];
    solicitante = json['solicitante'];
    mensaje = json['mensaje'];
    calificacion = double.parse(json['calificacion'].toString());
    fecha = json['fecha'];
    tipo = json['tipo'];
    estatus = json['estatus'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reporte != null) {
      data['reporte'] = reporte!.toJson();
    }
    data['_id'] = sId;
    data['cliente'] = cliente;
    data['solicitante'] = solicitante;
    data['mensaje'] = mensaje;
    data['calificacion'] = calificacion;
    data['fecha'] = fecha;
    data['tipo'] = tipo;
    data['estatus'] = estatus;
    data['__v'] = iV;
    return data;
  }

  static List<Opinion> fromJsonList(List list) {
    return list.map((e) => Opinion.fromJson(e)).toList();
  }
}

class Reporte {
  String? motivo;
  String? estado;

  Reporte({this.motivo, this.estado});

  Reporte.fromJson(Map<String, dynamic> json) {
    motivo = json['motivo'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['motivo'] = motivo;
    data['estado'] = estado;
    return data;
  }
}
