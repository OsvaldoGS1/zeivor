class Alerta {
  int? idAlerta;
  int? usuario;
  String? trabajo;
  String? descripcion;
  String? ubicacion;
  String? fecha;
  String? estatus;

  Alerta(
      {this.idAlerta,
      this.usuario,
      this.trabajo,
      this.descripcion,
      this.ubicacion,
      this.fecha,
      this.estatus});

  Alerta.fromJson(Map<String, dynamic> json) {
    idAlerta = json['id_alerta'];
    usuario = json['usuario'];
    trabajo = json['trabajo'];
    descripcion = json['descripcion'];
    ubicacion = json['ubicacion'];
    fecha = json['fecha'];
    estatus = json['estatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_alerta'] = idAlerta;
    data['usuario'] = usuario;
    data['trabajo'] = trabajo;
    data['descripcion'] = descripcion;
    data['ubicacion'] = ubicacion;
    data['fecha'] = fecha;
    data['estatus'] = estatus;
    return data;
  }

  static List<Alerta> fromJsonList(List list) {
    return list.map((e) => Alerta.fromJson(e)).toList();
  }
}
