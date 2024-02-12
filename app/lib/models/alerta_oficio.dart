class AlertaOficio {
  int? idAlerta;
  int? usuario;
  String? trabajo;
  String? descripcion;
  String? ubicacion;
  String? fecha;
  String? estatus;
  String? nombre;
  String? apellidoP;
  String? apellidoM;
  String? telefono;
  String? correo;

  AlertaOficio(
      {this.idAlerta,
      this.usuario,
      this.trabajo,
      this.descripcion,
      this.ubicacion,
      this.fecha,
      this.estatus,
      this.nombre,
      this.apellidoP,
      this.apellidoM,
      this.telefono,
      this.correo});

  AlertaOficio.fromJson(Map<String, dynamic> json) {
    idAlerta = json['id_alerta'];
    usuario = json['usuario'];
    trabajo = json['trabajo'];
    descripcion = json['descripcion'];
    ubicacion = json['ubicacion'];
    fecha = json['fecha'];
    estatus = json['estatus'];
    nombre = json['nombre'];
    apellidoP = json['apellido_p'];
    apellidoM = json['apellido_m'];
    telefono = json['telefono'];
    correo = json['correo'];
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
    data['nombre'] = nombre;
    data['apellido_p'] = apellidoP;
    data['apellido_m'] = apellidoM;
    data['telefono'] = telefono;
    data['correo'] = correo;
    return data;
  }

  static List<AlertaOficio> fromJsonList(List list) {
    return list.map((e) => AlertaOficio.fromJson(e)).toList();
  }
}
