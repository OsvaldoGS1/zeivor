// import 'package:app/models/oficio.dart';

class Usuario {
  String? sId;
  String? nombre;
  String? apellidoP;
  String? apellidoM;
  String? sexo;
  String? fechaNacimiento;
  String? correo;
  String? telefono;
  String? password;
  String? tipoUsuario;
  String? imagen;
  String? fechaRegistro;
  EstadoLugar? estadoLugar;
  String? auth;
  String? estatus;
  bool? verificado;
  List<String>? favoritos;
  String? token;
  int? iV;

  Usuario(
      {this.sId,
      this.nombre,
      this.apellidoP,
      this.apellidoM,
      this.sexo,
      this.fechaNacimiento,
      this.correo,
      this.telefono,
      this.password,
      this.tipoUsuario,
      this.imagen,
      this.fechaRegistro,
      this.estadoLugar,
      this.auth,
      this.estatus,
      this.verificado,
      this.favoritos,
      this.token,
      this.iV});

  Usuario.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nombre = json['nombre'];
    apellidoP = json['apellido_p'];
    apellidoM = json['apellido_m'];
    sexo = json['sexo'];
    fechaNacimiento = json['fecha_nacimiento'];
    correo = json['correo'];
    telefono = json['telefono'];
    password = json['password'];
    tipoUsuario = json['tipo_usuario'];
    imagen = json['imagen'];
    fechaRegistro = json['fecha_registro'];
    estadoLugar = json['estado_lugar'] != null
        ? EstadoLugar.fromJson(json['estado_lugar'])
        : null;
    auth = json['auth'];
    estatus = json['estatus'];
    verificado = json['verificado'];
    favoritos = json['favoritos'].cast<String>();
    token = json['token'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['nombre'] = nombre;
    data['apellido_p'] = apellidoP;
    data['apellido_m'] = apellidoM;
    data['sexo'] = sexo;
    data['fecha_nacimiento'] = fechaNacimiento;
    data['correo'] = correo;
    data['telefono'] = telefono;
    data['password'] = password;
    data['tipo_usuario'] = tipoUsuario;
    data['imagen'] = imagen;
    data['fecha_registro'] = fechaRegistro;
    if (estadoLugar != null) {
      data['estado_lugar'] = estadoLugar!.toJson();
    }
    data['auth'] = auth;
    data['estatus'] = estatus;
    data['verificado'] = verificado;
    // if (favoritos != null) {
    //   data['favoritos'] = favoritos!.map((v) => v.toJson()).toList();
    // }
    data['favoritos'] = favoritos;
    data['token'] = token;
    data['__v'] = iV;
    return data;
  }
}

class EstadoLugar {
  String? sId;
  String? nombre;
  String? clave;
  String? pais;

  EstadoLugar({this.sId, this.nombre, this.clave, this.pais});

  EstadoLugar.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nombre = json['nombre'];
    clave = json['clave'];
    pais = json['pais'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['nombre'] = nombre;
    data['clave'] = clave;
    data['pais'] = pais;
    return data;
  }
}
