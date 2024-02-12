class Favorito {
  int? idFavorito;
  int? idOficio;
  int? usuario;
  String? profesion;
  String? descripcion;
  String? metodosPago;
  String? celular;
  String? calificacion;
  String? ubicacion;
  String? imagen;
  String? estatus;
  String? nombre;
  String? apellidoP;
  String? apellidoM;
  String? correo;
  String? usuarioImagen;
  String? tipo;

  Favorito(
      {this.idFavorito,
      this.idOficio,
      this.usuario,
      this.profesion,
      this.descripcion,
      this.metodosPago,
      this.celular,
      this.calificacion,
      this.ubicacion,
      this.imagen,
      this.estatus,
      this.nombre,
      this.apellidoP,
      this.apellidoM,
      this.correo,
      this.tipo,
      this.usuarioImagen});

  Favorito.fromJson(Map<String, dynamic> json) {
    idFavorito = json['id_favorito'];
    idOficio = json['id_oficio'];
    usuario = json['usuario'];
    profesion = json['profesion'];
    descripcion = json['descripcion'];
    metodosPago = json['metodos_pago'];
    celular = json['celular'];
    calificacion = json['calificacion'];
    ubicacion = json['ubicacion'];
    imagen = json['imagen'];
    estatus = json['estatus'];
    nombre = json['nombre'];
    apellidoP = json['apellido_p'];
    apellidoM = json['apellido_m'];
    correo = json['correo'];
    tipo = json['tipo'];
    usuarioImagen = json['usuario_imagen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_favorito'] = idFavorito;
    data['id_oficio'] = idOficio;
    data['usuario'] = usuario;
    data['profesion'] = profesion;
    data['descripcion'] = descripcion;
    data['metodos_pago'] = metodosPago;
    data['celular'] = celular;
    data['calificacion'] = calificacion;
    data['ubicacion'] = ubicacion;
    data['imagen'] = imagen;
    data['estatus'] = estatus;
    data['nombre'] = nombre;
    data['apellido_p'] = apellidoP;
    data['apellido_m'] = apellidoM;
    data['correo'] = correo;
    data['tipo'] = tipo;
    data['usuario_Imagen'] = usuarioImagen;
    return data;
  }

  static List<Favorito> fromJsonList(List list) {
    return list.map((i) => Favorito.fromJson(i)).toList();
  }
}
