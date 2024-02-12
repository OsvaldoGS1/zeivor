part of './app_pages.dart';

abstract class Routes {
  //Inicio //Inicio //Inicio  //Inicio  //Inicio  //Inicio
  static const login = '/login';
  static const registro = '/registro';
  static const recuperar = '/recuperar';

  //Home  //Home  //Home  //Home  //Home  //Home  //Home  //Home

  static const home = '/home';
  static const permisoUbi = '/permiso';

  //Buscar  //Buscar  //Buscar  //Buscar  //Buscar  //Buscar  //Buscar

  static const buscar = '/buscar';
  static const mapabusqueda = '/mapa';

  static const contacto = '/buscar/enviar/contacto';

  //Favoritos //Favoritos //Favoritos //Favoritos //Favoritos //Favoritos //Favoritos

  static const favoritos = '/favoritos';

  //Filtros //Filtros //Filtros //Filtros //Filtros //Filtros //Filtros

  static const filtros = '/filtros';

  //Usuario Menu  //Usuario Menu  //Usuario Menu  //Usuario Menu  //Usuario Menu

  static const usuario = '/usuario';
  static const servicios = '/usuario/ofrecer';
  static const servicios2 = '/usuario/ofrecer/2';
  static const servicios3 = '/usuario/ofrecer/3';
  static const pagos = '/usuario/ofrecer/pagos';

  //Contratacion  //Contratacion  //Contratacion
  static const contratacion = '/usuario/contratacion';
  static const contratacionInformacion = '/usuario/contratacion/informacion';

  static const configuracion = '/usuario/configuracion';
  static const permisos = '/usuario/configuracion/permisos';
  static const informacionPersonal = '/usuario/informacion';
  static const notificacion = '/usuario/notificacion';
  static const notiMensaje = '/usuario/notificacion/mensaje';

  static const alerta = '/usuario/alerta';
  static const alertaOficio = '/usuario/alerta_oficio';

  static const perfilTrabajador = '/usuario/perfil';

  //ubicacion     //ubicacion     //ubicacion     //ubicacion     //ubicacion     //ubicacion     //ubicacion
  static const ubicacion = '/ubicacion';

  //Detalles   //Detalles   //Detalles   //Detalles   //Detalles   //Detalles   //Detalles
  static const detalles = '/detalles';
  static const mensaje = '/detalles/enviar';

  //Administrador   //Administrador   //Administrador   //Administrador   //Administrador   //Administrador

  static const adminstrador = '/administrador';
}
