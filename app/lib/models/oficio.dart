class Oficio {
  int? idOficio;
  int? usuario;
  String? profesion;
  String? descripcion;
  String? metodosPago;
  String? celular;
  String? ubicacion;
  String? imagen;
  String? visitaCobro;
  int? direccion;
  String? estatus;
  String? identificacion;
  String? selfie;
  String? carta;
  String? referencia1;
  String? referencia2;
  String? referencia3;
  int? idDireccion;
  String? calle;
  String? colonia;
  String? cp;
  String? municipio;
  String? estado;
  String? pais;
  String? visible;

  Oficio(
      {this.idOficio,
      this.usuario,
      this.profesion,
      this.descripcion,
      this.metodosPago,
      this.celular,
      this.ubicacion,
      this.imagen,
      this.visitaCobro,
      this.direccion,
      this.estatus,
      this.identificacion,
      this.selfie,
      this.carta,
      this.referencia1,
      this.referencia2,
      this.referencia3,
      this.idDireccion,
      this.calle,
      this.colonia,
      this.cp,
      this.municipio,
      this.estado,
      this.pais,
      this.visible});

  Oficio.fromJson(Map<String, dynamic> json) {
    idOficio = json['id_oficio'];
    usuario = json['usuario'];
    profesion = json['profesion'];
    descripcion = json['descripcion'];
    metodosPago = json['metodos_pago'];
    celular = json['celular'];
    ubicacion = json['ubicacion'];
    imagen = json['imagen'];
    visitaCobro = json['visita_cobro'];
    direccion = json['direccion'];
    estatus = json['estatus'];
    identificacion = json['identificacion'];
    selfie = json['selfie'];
    carta = json['carta'];
    referencia1 = json['referencia1'];
    referencia2 = json['referencia2'];
    referencia3 = json['referencia3'];
    idDireccion = json['id_direccion'];
    calle = json['calle'];
    colonia = json['colonia'];
    cp = json['cp'];
    municipio = json['municipio'];
    estado = json['estado'];
    pais = json['pais'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_oficio'] = idOficio;
    data['usuario'] = usuario;
    data['profesion'] = profesion;
    data['descripcion'] = descripcion;
    data['metodos_pago'] = metodosPago;
    data['celular'] = celular;
    data['ubicacion'] = ubicacion;
    data['imagen'] = imagen;
    data['visita_cobro'] = visitaCobro;
    data['direccion'] = direccion;
    data['estatus'] = estatus;
    data['identificacion'] = identificacion;
    data['selfie'] = selfie;
    data['carta'] = carta;
    data['referencia1'] = referencia1;
    data['referencia2'] = referencia2;
    data['referencia3'] = referencia3;
    data['id_direccion'] = idDireccion;
    data['calle'] = calle;
    data['colonia'] = colonia;
    data['cp'] = cp;
    data['municipio'] = municipio;
    data['estado'] = estado;
    data['pais'] = pais;
    data['visible'] = visible;
    return data;
  }

  static List<Oficio> fromJsonList(List list) {
    return list.map((e) => Oficio.fromJson(e)).toList();
  }
}
