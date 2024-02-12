class Oferta {
  int? idContacto;
  String? fecha;
  String? mensaje;
  String? localizacion;
  String? estatus;
  String? estatusTrabajador;
  String? estatusCliente;
  int? idUsuario;
  String? nombre;
  String? apellidoP;
  String? apellidoM;
  String? correo;
  String? telefono;
  String? imagen;
  String? tipo;

  Oferta(
      {this.idContacto,
      this.fecha,
      this.mensaje,
      this.localizacion,
      this.estatus,
      this.estatusTrabajador,
      this.estatusCliente,
      this.idUsuario,
      this.nombre,
      this.apellidoP,
      this.apellidoM,
      this.correo,
      this.telefono,
      this.imagen,
      this.tipo});

  Oferta.fromJson(Map<String, dynamic> json) {
    idContacto = json['id_contacto'];
    fecha = json['fecha'];
    mensaje = json['mensaje'];
    localizacion = json['localizacion'];
    estatus = json['estatus'];
    estatusTrabajador = json['estatus_trabajador'];
    estatusCliente = json['estatus_cliente'];
    idUsuario = json['id_usuario'];
    nombre = json['nombre'];
    apellidoP = json['apellido_p'];
    apellidoM = json['apellido_m'];
    correo = json['correo'];
    telefono = json['telefono'];
    imagen = json['imagen'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_contacto'] = idContacto;
    data['fecha'] = fecha;
    data['mensaje'] = mensaje;
    data['localizacion'] = localizacion;
    data['estatus'] = estatus;
    data['estatus_trabajador'] = estatusTrabajador;
    data['estatus_cliente'] = estatusCliente;
    data['id_usuario'] = idUsuario;
    data['nombre'] = nombre;
    data['apellido_p'] = apellidoP;
    data['apellido_m'] = apellidoM;
    data['correo'] = correo;
    data['telefono'] = telefono;
    data['imagen'] = imagen;
    data['tipo'] = tipo;
    return data;
  }

  static List<Oferta> fromJsonList(List list) {
    return list.map((e) => Oferta.fromJson(e)).toList();
  }
}
