import 'package:app/screens/Inicio/login/login.dart';
import 'package:app/screens/Inicio/login/login_binding.dart';
import 'package:app/screens/Inicio/recuperar/recuperar.dart';
import 'package:app/screens/Inicio/recuperar/recuperar_binding.dart';
import 'package:app/screens/Inicio/registro/registro.dart';
import 'package:app/screens/Inicio/registro/registro_binding.dart';
import 'package:app/screens/administrador/administrador_binding.dart';
import 'package:app/screens/administrador/administrador_view.dart';
import 'package:app/screens/buscar/buscar.dart';
import 'package:app/screens/buscar/buscar_binding.dart';
import 'package:app/screens/buscar/mapa/mapa_ubicacion.dart';
import 'package:app/screens/enviar_mensaje/detalles/detalles_binding.dart';
import 'package:app/screens/enviar_mensaje/detalles/detalles_view.dart';
// import 'package:app/screens/favoritos/enviar_mensaje/contacto.dart';
import 'package:app/screens/enviar_mensaje/enviar_mensaje.dart';
import 'package:app/screens/favoritos/favoritos_binding.dart';
import 'package:app/screens/favoritos/favoritos_view.dart';
import 'package:app/screens/filtros/filtros_binding.dart';
import 'package:app/screens/filtros/filtros_view.dart';
import 'package:app/screens/home/home.dart';
import 'package:app/screens/home/home_binding.dart';
import 'package:app/screens/home/permisos_ubicacion/permiso_ubicacion.dart';
import 'package:app/screens/home/permisos_ubicacion/permiso_ubicacion_binding.dart';
import 'package:app/screens/ubicacion/ubicacion_binding.dart';
import 'package:app/screens/ubicacion/ubicacion_view.dart';
import 'package:app/screens/usuario/alertas/alerta_binding.dart';
import 'package:app/screens/usuario/alertas/alerta_view.dart';
import 'package:app/screens/usuario/alertas_oficio/alertas_oficio_binding.dart';
import 'package:app/screens/usuario/alertas_oficio/alertas_oficio_view.dart';
import 'package:app/screens/usuario/configuracion/configuracion_binding.dart';
import 'package:app/screens/usuario/configuracion/configuracion_view.dart';
import 'package:app/screens/usuario/configuracion/permisos/permisos_view.dart';
import 'package:app/screens/usuario/contrataciones/contratacion_binding.dart';
import 'package:app/screens/usuario/contrataciones/contratacion_view.dart';
import 'package:app/screens/usuario/contrataciones/informacion/contratacion_informacion.dart';
import 'package:app/screens/usuario/informacion_personal/informacion_binding.dart';
import 'package:app/screens/usuario/informacion_personal/informacion_view.dart';
import 'package:app/screens/usuario/notificaciones/mensaje/mensaje_binding.dart';
import 'package:app/screens/usuario/notificaciones/mensaje/mensaje_view.dart';
import 'package:app/screens/usuario/notificaciones/notificaciones_binding.dart';
import 'package:app/screens/usuario/notificaciones/notificaciones_view.dart';
import 'package:app/screens/usuario/ofrecer_servicios/pagos/pagos_binding.dart';
import 'package:app/screens/usuario/ofrecer_servicios/pagos/pagos_view.dart';
import 'package:app/screens/usuario/ofrecer_servicios/servicios_binding.dart';
import 'package:app/screens/usuario/ofrecer_servicios/servicios_view.dart';
import 'package:app/screens/usuario/ofrecer_servicios/servicios_view_2.dart';
import 'package:app/screens/usuario/ofrecer_servicios/servicios_view_3.dart';
import 'package:app/screens/usuario/perfil_trabajador/perfil_trabajador_binding.dart';
import 'package:app/screens/usuario/perfil_trabajador/perfil_trabajador_view.dart';
import 'package:app/screens/usuario/usuario_binding.dart';
import 'package:app/screens/usuario/usuario_view.dart';
import 'package:get/route_manager.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    //Inicio //Inicio //Inicio  //Inicio  //Inicio  //Inicio
    GetPage(
        name: Routes.login,
        page: () => const LoginView(),
        binding: LoginBinding(),
        transitionDuration: const Duration(seconds: 2),
        transition: Transition.cupertino),
    GetPage(
        name: Routes.registro,
        page: () => const RegistroView(),
        binding: RegistroBinding()),

    GetPage(
        name: Routes.recuperar,
        page: () => const RecuperarView(),
        binding: RecuperarBinding()),

    //Home  //Home  //Home  //Home  //Home  //Home  //Home  //Home

    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.permisoUbi,
      page: () => const PermisoUbicacionView(),
      binding: PermisoUbicacionBindings(),
    ),

    //Buscar  //Buscar  //Buscar  //Buscar  //Buscar  //Buscar  //Buscar

    GetPage(
        name: Routes.buscar,
        page: () => const BuscarView(),
        binding: BuscarBinding()),
    GetPage(
        name: Routes.mapabusqueda,
        page: () => const MapaUbicacionView(),
        binding: BuscarBinding()),

    //Favoritos //Favoritos //Favoritos //Favoritos //Favoritos //Favoritos //Favoritos

    GetPage(
        name: Routes.favoritos,
        page: () => const FavoritosView(),
        binding: FavoritosBinding()),

    // GetPage(
    //     name: Routes.contacto,
    //     page: () => const ContactoView(),
    //     binding: FavoritosBinding()),

    //Detalles   //Detalles   //Detalles   //Detalles   //Detalles   //Detalles   //Detalles
    GetPage(
        name: Routes.detalles,
        page: () => const DetallesView(),
        binding: DetallesBinding(),
        transitionDuration: const Duration(milliseconds: 1200),
        transition: Transition.circularReveal),

    GetPage(
        name: Routes.mensaje,
        page: () => const EnviarMensaje(),
        binding: DetallesBinding(),
        transitionDuration: const Duration(milliseconds: 1200),
        transition: Transition.fade),

    //Filtros //Filtros //Filtros //Filtros //Filtros //Filtros //Filtros

    GetPage(
        name: Routes.filtros,
        page: () => const FiltrosView(),
        binding: FiltrosBindging()),

    //Usuario Menu  //Usuario Menu  //Usuario Menu  //Usuario Menu  //Usuario Menu

    GetPage(
        name: Routes.usuario,
        page: () => const UsuarioView(),
        binding: UsuarioBinding(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 800)),
    GetPage(
        name: Routes.informacionPersonal,
        page: () => const InformacionView(),
        binding: InformacionBinding()),
    GetPage(
        name: Routes.notificacion,
        page: () => const NotificacionesView(),
        binding: NotificacionesBinding()),
    GetPage(
        name: Routes.notiMensaje,
        page: () => const MensajeView(),
        binding: MensajeBinding()),

    GetPage(
      name: Routes.servicios,
      page: () => const OfrecerServiciosView(),
      binding: ServiciosBinding(),
    ),
    GetPage(
      name: Routes.servicios2,
      page: () => const OfrecerServiciosView2(),
      binding: ServiciosBinding(),
    ),
    GetPage(
      name: Routes.servicios3,
      page: () => const OfrecerServiciosView3(),
      binding: ServiciosBinding(),
    ),

    GetPage(
      name: Routes.contratacion,
      page: () => const ContratacionView(),
      binding: ContratacionBinding(),
    ),
    GetPage(
      name: Routes.contratacionInformacion,
      page: () => const InformacionContratacionView(),
      binding: ContratacionBinding(),
    ),

    GetPage(
      name: Routes.configuracion,
      page: () => const ConfiguracionView(),
      binding: ConfiguracionBinding(),
    ),

    GetPage(
      name: Routes.permisos,
      page: () => const PermisosView(),
      binding: ConfiguracionBinding(),
    ),

    GetPage(
      name: Routes.pagos,
      page: () => const PagosView(),
      binding: PagosBinding(),
    ),

    GetPage(
        name: Routes.alerta,
        page: () => const AlertaView(),
        binding: AlertaBinding()),

    GetPage(
        name: Routes.alertaOficio,
        page: () => const AlertasOficioView(),
        binding: AlertasOficioBinding()),

    GetPage(
        name: Routes.perfilTrabajador,
        page: () => const PerfilTrabajadorView(),
        binding: PerfilTrabajadorBinding()),

    ///Ubicacion
    ///

    GetPage(
        name: Routes.ubicacion,
        page: () => const UbicacionView(),
        binding: UbicacionBinding()),

    //Administrador   //Administrador   //Administrador   //Administrador   //Administrador   //Administrador

    GetPage(
        name: Routes.adminstrador,
        page: () => const AdministradorView(),
        binding: AdministradorBinding())
  ];
}
