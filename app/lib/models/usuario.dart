class Usuario {
  int? idUsuario;
  String? nombre;
  String? apellidoP;
  String? apellidoM;
  String? correo;
  String? usuario;
  String? telefono;
  String? password;
  String? direccion;
  int? tipoUsuario;
  String? imagen;
  String? fechaRegistro;
  String? estatus;
  String? token;
  String? tipo;

  Usuario(
      {this.idUsuario,
      this.nombre,
      this.apellidoP,
      this.apellidoM,
      this.correo,
      this.usuario,
      this.telefono,
      this.password,
      this.direccion,
      this.tipoUsuario,
      this.imagen,
      this.fechaRegistro,
      this.estatus,
      this.tipo,
      this.token});

  Usuario.fromJson(Map<String, dynamic> json) {
    idUsuario = json['id_usuario'];
    nombre = json['nombre'];
    apellidoP = json['apellido_p'];
    apellidoM = json['apellido_m'];
    correo = json['correo'];
    usuario = json['usuario'];
    telefono = json['telefono'];
    password = json['password'];
    direccion = json['direccion'];
    tipoUsuario = json['tipo_usuario'];
    imagen = json['imagen'];
    fechaRegistro = json['fecha_registro'];
    estatus = json['estatus'];
    tipo = json['tipo'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_usuario'] = idUsuario;
    data['nombre'] = nombre;
    data['apellido_p'] = apellidoP;
    data['apellido_m'] = apellidoM;
    data['correo'] = correo;
    data['usuario'] = usuario;
    data['telefono'] = telefono;
    data['password'] = password;
    data['direccion'] = direccion;
    data['tipo_usuario'] = tipoUsuario;
    data['imagen'] = imagen;
    data['fecha_registro'] = fechaRegistro;
    data['estatus'] = estatus;
    data['tipo'] = tipo;
    data['token'] = token;
    return data;
  }
}
