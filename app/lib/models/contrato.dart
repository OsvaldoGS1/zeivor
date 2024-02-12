class Contrato {
  int? idContacto;
  String? fecha;
  String? mensaje;
  String? estatusTrabajador;
  String? estatusCliente;
  String? localizacion;
  String? estado;
  int? idOficio;
  int? usuario;
  String? profesion;
  String? descripcion;
  String? metodosPago;
  String? celular;
  String? ubicacion;
  String? imagen;
  String? visitaCobro;
  String? estatus;
  String? calificacion;
  String? nombre;
  String? apellidoP;
  String? apellidoM;
  String? correo;
  String? usuarioImagen;
  String? tipo;

  Contrato(
      {this.idContacto,
      this.fecha,
      this.mensaje,
      this.estatusTrabajador,
      this.estatusCliente,
      this.localizacion,
      this.estado,
      this.idOficio,
      this.usuario,
      this.profesion,
      this.descripcion,
      this.metodosPago,
      this.celular,
      this.ubicacion,
      this.imagen,
      this.visitaCobro,
      this.estatus,
      this.calificacion,
      this.nombre,
      this.apellidoP,
      this.apellidoM,
      this.correo,
      this.usuarioImagen,
      this.tipo});

  Contrato.fromJson(Map<String, dynamic> json) {
    idContacto = json['id_contacto'];
    fecha = json['fecha'];
    mensaje = json['mensaje'];
    estatusTrabajador = json['estatus_trabajador'];
    estatusCliente = json['estatus_cliente'];
    localizacion = json['localizacion'];
    estado = json['estado'];
    idOficio = json['id_oficio'];
    usuario = json['usuario'];
    profesion = json['profesion'];
    descripcion = json['descripcion'];
    metodosPago = json['metodos_pago'];
    celular = json['celular'];
    ubicacion = json['ubicacion'];
    imagen = json['imagen'];
    visitaCobro = json['visita_cobro'];
    estatus = json['estatus'];
    calificacion = json['calificacion'];
    nombre = json['nombre'];
    apellidoP = json['apellido_p'];
    apellidoM = json['apellido_m'];
    correo = json['correo'];
    usuarioImagen = json['usuario_imagen'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_contacto'] = idContacto;
    data['fecha'] = fecha;
    data['mensaje'] = mensaje;
    data['estatus_trabajador'] = estatusTrabajador;
    data['estatus_cliente'] = estatusCliente;
    data['localizacion'] = localizacion;
    data['estado'] = estado;
    data['id_oficio'] = idOficio;
    data['usuario'] = usuario;
    data['profesion'] = profesion;
    data['descripcion'] = descripcion;
    data['metodos_pago'] = metodosPago;
    data['celular'] = celular;
    data['ubicacion'] = ubicacion;
    data['imagen'] = imagen;
    data['visita_cobro'] = visitaCobro;
    data['estatus'] = estatus;
    data['calificacion'] = calificacion;
    data['nombre'] = nombre;
    data['apellido_p'] = apellidoP;
    data['apellido_m'] = apellidoM;
    data['correo'] = correo;
    data['usuario_imagen'] = usuarioImagen;
    data['tipo'] = tipo;
    return data;
  }

  static List<Contrato> fromJsonList(List list) {
    return list.map((e) => Contrato.fromJson(e)).toList();
  }
}
