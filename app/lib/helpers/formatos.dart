// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'dart:math';

class Formato {
  String dinero(String valor) {
    double cantidad = double.parse(valor);
    return NumberFormat.currency(locale: 'es_mx', symbol: '\$')
        .format(cantidad);
  }

  String formatingDate(String fecha) {
    return DateFormat('dd-MMMM-yyyy', 'es')
        .format(DateTime.parse(fecha).toLocal());
  }

  String formatingDateHour(String fecha) {
    return DateFormat('dd-MMMM-yyyy  hh:mm a', 'es')
        .format(DateTime.parse(fecha).toLocal());
  }

  String formatoHoraDia(String fecha) {
    DateTime fechaContacto = DateTime.parse(fecha).toLocal();
    DateTime ahora = DateTime.now();

    // Calcular la diferencia de tiempo en minutos y días
    int diferenciaEnMinutos = ahora.difference(fechaContacto).inMinutes;
    int diferenciaEnDias = ahora.difference(fechaContacto).inDays;

    if (diferenciaEnMinutos < 60) {
      // Si la diferencia es menor a 60 minutos, mostrar los minutos
      return 'hace $diferenciaEnMinutos minutos';
    } else if (diferenciaEnDias == 0) {
      // Si la diferencia es dentro del mismo día, mostrar las horas
      int horas = diferenciaEnMinutos ~/ 60;
      return 'hace $horas horas';
    } else if (diferenciaEnDias <= 3) {
      // Si la diferencia es de 1 a 3 días, mostrar los días
      return 'hace $diferenciaEnDias días';
    } else {
      // Si han pasado más de 3 días, mostrar la fecha completa del contacto
      return DateFormat('el dd-MMMM-yyyy  hh:mm a', 'es').format(fechaContacto);
    }
  }

  String obtenerDistancia(String coordenadas1, String coordenadas2) {
    String distancia = '';
    var lista = coordenadas1.trim().split(',');
    var lista2 = coordenadas2.trim().split(',');

    double lat1 = double.parse(lista[0]);
    double lon1 = double.parse(lista[1]);
    double lat2 = double.parse(lista2[0]);
    double lon2 = double.parse(lista2[1]);
    double calculo = calculateDistance(lat1, lon1, lat2, lon2);
    if (calculo < 1.0) {
      distancia = '${(calculo * 1000)} mts';
    } else {
      distancia = '${calculo.toStringAsFixed(2)} KM';
    }
    // distancia = '$calculo';
    return distancia;
  }

  double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    int radiusEarth = 6371;
    double distanceKm;
    double distanceMts;
    double dlat, dlng;
    double a;
    double c;

    //Convertimos de grados a radianes
    lat1 = math.radians(lat1);
    lat2 = math.radians(lat2);
    lng1 = math.radians(lng1);
    lng2 = math.radians(lng2);
    // Fórmula del semiverseno
    dlat = lat2 - lat1;
    dlng = lng2 - lng1;
    a = sin(dlat / 2) * sin(dlat / 2) +
        cos(lat1) * cos(lat2) * (sin(dlng / 2)) * (sin(dlng / 2));
    c = 2 * atan2(sqrt(a), sqrt(1 - a));

    distanceKm = radiusEarth * c;
    // print('Distancia en Kilométros:$distanceKm');
    distanceMts = 1000 * distanceKm;
    // print('Distancia en Metros:$distanceMts');

    return distanceKm;
    //return distanceMts;
  }
}
