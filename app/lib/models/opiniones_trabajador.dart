class OpinionTrabajador {
  int? idCalificacion;
  int? oficio;
  String? mensaje;
  String? calificacion;
  int? usuario;
  String? fecha;
  String? nombre;

  OpinionTrabajador(
      {this.idCalificacion,
      this.oficio,
      this.mensaje,
      this.calificacion,
      this.usuario,
      this.fecha,
      this.nombre});

  OpinionTrabajador.fromJson(Map<String, dynamic> json) {
    idCalificacion = json['id_calificacion'];
    oficio = json['oficio'];
    mensaje = json['mensaje'];
    calificacion = json['calificacion'];
    usuario = json['usuario'];
    fecha = json['fecha'];
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_calificacion'] = idCalificacion;
    data['oficio'] = oficio;
    data['mensaje'] = mensaje;
    data['calificacion'] = calificacion;
    data['usuario'] = usuario;
    data['fecha'] = fecha;
    data['nombre'] = nombre;
    return data;
  }

  static List<OpinionTrabajador> fromJsonList(List list) {
    return list.map((e) => OpinionTrabajador.fromJson(e)).toList();
  }
}
