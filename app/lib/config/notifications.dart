// import 'package:firebase_messaging/firebase_messaging.dart';

// import 'dart:io';
// import 'dart:async';

// //  Clase para manejar todas las notificaciones
// class PushNotificationProvider {
//   FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

//   final _mensajesStreamController = StreamController<String>.broadcast();
//   Stream<String> get mensajes => _mensajesStreamController.stream;

//   initNotifications() {
//     firebaseMessaging
//         .requestNotificationPermissions(); // Pedimos permiso al usuario para usar notificaciones

//     firebaseMessaging!.getToken().then((token) {
//       //  Obtenemos el token del dispositivo

//       print('===== FCM Token =====');
//       print(token);
//       // fMKLkNe9I24:APA91bGRdrUxRhYoTDlzYW0vzjsv-ebKLyfYX7u1RahKyn_1hUfOWeQmYqEZ6qFlQ25blXtkE3VSqNgnec4KpqqiTy5zDWd-VsaUz6l2jT6G7mCChcoNNezjElv2Wpkh5qd0jfZ4zmGo
//     });

//     firebaseMessaging.configure(onMessage: (info) async {
//       //  Se dispara cuando nuestra aplicación está abierta

//       print('======= On Message ========');
//       print(info);

//       String argumento = 'no-data';
//       if (Platform.isAndroid) {
//         argumento = info['data']['comida'] ?? 'no-data';
//       } else {
//         argumento = info['comida'] ?? 'no-data-ios';
//       }

//       _mensajesStreamController.sink.add(argumento);
//     }, onLaunch: (info) async {
//       // Se dispara cuando la aplicación está en segundo plano

//       print('======= On Launch ========');
//       print(info);
//     }, onResume: (info) async {
//       // Se dispara cuando la aplicación está cerrada

//       print('======= On Resume ========');
//       print(info);

//       String argumento = 'no-data';

//       if (Platform.isAndroid) {
//         argumento = info['data']['comida'] ?? 'no-data';
//       } else {
//         argumento = info['comida'] ?? 'no-data-ios';
//       }

//       _mensajesStreamController.sink.add(argumento);
//     });
//   }

//   dispose() {
//     _mensajesStreamController?.close();
//   }
// }
