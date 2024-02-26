import 'package:app/models/usuario.dart';

class Cliente {
  MetodosPago? metodosPago;
  Direccion? direccion;
  String? sId;
  Usuario? usuario;
  String? profesion;
  String? descripcion;
  String? celular;
  String? ubicacion;
  String? imagen;
  String? visitaCobro;
  bool? emiteFactura;
  List<String>? imagenesTrabajo;
  String? identificacion;
  String? selfie;
  String? cartaPenal;
  List<String>? referencia;
  List<String>? palabrasClaves;
  List<String>? opiniones;
  String? estatus;
  bool? verificado;
  DateTime? fechaVencimiento;
  double? calificacion;
  int? iV;

  Cliente(
      {this.metodosPago,
      this.direccion,
      this.sId,
      this.usuario,
      this.profesion,
      this.descripcion,
      this.celular,
      this.ubicacion,
      this.imagen,
      this.visitaCobro,
      this.emiteFactura,
      this.imagenesTrabajo,
      this.identificacion,
      this.selfie,
      this.cartaPenal,
      this.referencia,
      this.palabrasClaves,
      this.opiniones,
      this.estatus,
      this.verificado,
      this.fechaVencimiento,
      this.calificacion,
      this.iV});

  Cliente.fromJson(Map<String, dynamic> json) {
    metodosPago = json['metodos_pago'] != null
        ? MetodosPago.fromJson(json['metodos_pago'])
        : null;
    direccion = json['direccion'] != null
        ? Direccion.fromJson(json['direccion'])
        : null;
    sId = json['_id'];
    usuario =
        json['usuario'] != null ? Usuario.fromJson(json['usuario']) : null;
    profesion = json['profesion'];
    descripcion = json['descripcion'];
    celular = json['celular'];
    ubicacion = json['ubicacion'];
    imagen = json['imagen'];
    visitaCobro = json['visita_cobro'];
    emiteFactura = json['emite_factura'];
    imagenesTrabajo = json['imagenes_trabajo'].cast<String>();
    identificacion = json['identificacion'];
    selfie = json['selfie'];
    cartaPenal = json['carta_penal'];
    referencia = json['referencia'].cast<String>();
    palabrasClaves = json['palabras_claves'].cast<String>();
    opiniones = json['opiniones'].cast<String>();
    estatus = json['estatus'];
    verificado = json['verificado'];
    fechaVencimiento = json['fecha_vencimiento'];
    calificacion = double.parse(json['calificacion'].toString());
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (metodosPago != null) {
      data['metodos_pago'] = metodosPago!.toJson();
    }
    if (direccion != null) {
      data['direccion'] = direccion!.toJson();
    }
    data['_id'] = sId;
    if (usuario != null) {
      data['usuario'] = usuario!.toJson();
    }
    data['profesion'] = profesion;
    data['descripcion'] = descripcion;
    data['celular'] = celular;
    data['ubicacion'] = ubicacion;
    data['imagen'] = imagen;
    data['visita_cobro'] = visitaCobro;
    data['emite_factura'] = emiteFactura;
    data['imagenes_trabajo'] = imagenesTrabajo;
    data['identificacion'] = identificacion;
    data['selfie'] = selfie;
    data['carta_penal'] = cartaPenal;
    data['referencia'] = referencia;
    data['palabras_claves'] = palabrasClaves;
    data['opiniones'] = opiniones;
    data['estatus'] = estatus;
    data['verificado'] = verificado;
    data['fecha_vencimiento'] = fechaVencimiento;
    data['calificacion'] = calificacion;
    data['__v'] = iV;
    return data;
  }

  static List<Cliente> fromJsonList(List list) {
    return list.map((e) => Cliente.fromJson(e)).toList();
  }
}

class MetodosPago {
  bool? tarjeta;
  bool? transferencia;
  bool? efectivo;

  MetodosPago({this.tarjeta, this.transferencia, this.efectivo});

  MetodosPago.fromJson(Map<String, dynamic> json) {
    tarjeta = json['tarjeta'];
    transferencia = json['transferencia'];
    efectivo = json['efectivo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tarjeta'] = tarjeta;
    data['transferencia'] = transferencia;
    data['efectivo'] = efectivo;
    return data;
  }
}

class Direccion {
  String? calle;
  int? cp;
  String? colonia;
  String? municipio;
  String? estado;
  String? pais;
  bool? visible;

  Direccion(
      {this.calle,
      this.cp,
      this.colonia,
      this.municipio,
      this.estado,
      this.pais,
      this.visible});

  Direccion.fromJson(Map<String, dynamic> json) {
    calle = json['calle'];
    cp = json['cp'];
    colonia = json['colonia'];
    municipio = json['municipio'];
    estado = json['estado'];
    pais = json['pais'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['calle'] = calle;
    data['cp'] = cp;
    data['colonia'] = colonia;
    data['municipio'] = municipio;
    data['estado'] = estado;
    data['pais'] = pais;
    data['visible'] = visible;
    return data;
  }
}
