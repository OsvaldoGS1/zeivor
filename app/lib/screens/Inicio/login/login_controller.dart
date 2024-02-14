import 'dart:io';
import 'dart:math';

import 'package:app/helpers/api.dart';
import 'package:app/helpers/data.dart';
import 'package:app/models/usuario.dart';
import 'package:app/routes/app_pages.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';

import 'dart:convert' show utf8;

class LoginController extends GetxController {
  RxBool visiblePassword = true.obs;
  // RxBool isLoggeado = false.obs;
  RxBool isLoading = false.obs;

  Usuario? usuario;
  Datos datos = Datos();

  @override
  void onInit() async {
    await isBiometricType();
    obtenerUsuario();

    super.onInit();
  }

  void obtenerUsuario() {
    // datos.checkLogin();
    usuario = datos.recoveryData();
    if (usuario != null && usuario!.tipo == 'ninguno') {
      correo.text = usuario!.correo ?? '';
    }
  }

  //Iniciar sesion  //Iniciar sesion  //Iniciar sesion  //Iniciar sesion  //Iniciar sesion

  TextEditingController correo = TextEditingController();
  TextEditingController contrasena = TextEditingController();

  Future login() async {
    ApiService apiService = ApiService();
    if (correo.text.isEmpty || contrasena.text.isEmpty) {
      snackbar('Llene los campos solicitados', '');
      return;
    }
    isLoading.value = true;
    try {
      Map<String, dynamic> body = {
        "correo": correo.text,
        "password": contrasena.text
      };
      final respuesta = await apiService.fetchData('usuario/login',
          method: Method.POST, body: body);

      if (apiService.status == 200) {
        Datos datos = Datos();
        datos.logOut();
        datos.login(respuesta['resultado']);
        Usuario user = datos.recoveryData();
        if (user.tipoUsuario == 3) {
          await Get.offAllNamed(Routes.adminstrador);
        } else {
          await Get.offAllNamed(Routes.home);
        }
      } else {
        snackbar(respuesta['message'], '');
      }
    } catch (error) {
      snackbar('Error', error.toString());
    }
    isLoading.value = false;
  }

  RxString acceso = ''.obs;
  RxBool isBiometric = false.obs;

  Future isBiometricType() async {
    LocalAuthentication localAuthentication = LocalAuthentication();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    List<BiometricType> listaAutenticacion;
    if (canCheckBiometrics) {
      listaAutenticacion = await localAuthentication.getAvailableBiometrics();
      if (listaAutenticacion.isNotEmpty) {
        if (BiometricType.face == listaAutenticacion[0]) {
          acceso.value = 'Face ID';
          isBiometric.value = true;
        } else {
          acceso.value = 'huella';
          isBiometric.value = true;
        }
      }
    } else {
      isBiometric.value = false;
    }
  }

  Future entrar() async {
    final LocalAuthentication auth = LocalAuthentication();
    // Get.snackbar('title', '');
    try {
      bool authenticate = await auth.authenticate(
          localizedReason:
              'Para continuar con su sesion, es necesario que se autentifique.',
          options: const AuthenticationOptions(
              biometricOnly: true, stickyAuth: true));
      if (authenticate) {
        Usuario user = Datos().recoveryData();
        if (user.tipoUsuario == 3) {
          await Get.offAllNamed(Routes.adminstrador);
        } else {
          await Get.offAllNamed(Routes.home);
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future ingresar(String tipo) async {
    isLoading.value = true;
    try {
      UserCredential? userCredential;
      switch (tipo) {
        case "google":
          userCredential = await authGmail();
          break;
        case "apple":
          userCredential = await authApple();
          break;
        case "facebook":
          // userCredential = await authFacebook();
          break;
      }

      String fecha = DateTime.now().toLocal().toString();
      if (userCredential != null) {
        // print(userCredential);/
        // if (!userCredential.additionalUserInfo!.isNewUser) {
        //   await Get.offAllNamed(Routes.home);
        //   return;
        // }
        ApiService apiService = ApiService();
        Map<String, dynamic> body = {
          "correo": userCredential.user!.email,
          "nombre":
              tipo == 'apple' ? nombre.value : userCredential.user!.displayName,
          "imagen": userCredential.user!.photoURL ?? '',
          "fecha": fecha,
          "tipo": tipo,
          "apellido": tipo == 'apple' ? apellido.value : ''
        };
        final respuesta = await apiService.fetchData('usuario/registro_redes',
            method: Method.POST, body: body);
        if (apiService.status == 200) {
          Datos datos = Datos();
          datos.logOut();
          datos.login(respuesta);
          await Get.offAllNamed(Routes.home);
        } else {
          snackbar('Error', 'Error al registrar sus datos en nuestro sistema');
        }
      } else {
        snackbar('Error', 'Error al iniciar sesion con $tipo');
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    isLoading.value = false;
  }

  //Metodo para iniciar sesion con Google (Gmail)

  Future<UserCredential?> authGmail() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      ///Se lanza la vista para que el usuario inicie sesion con google o
      ///escoja alguna de las cuentas que tenga disponible en su dispostivo
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      //Se agregan la informacion a firebase console.
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      ///Se regresan las credenciales para su posterior uso
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      if (kDebugMode) {
        print("Error en el inicio de sesión con Gmail: $error");
      }
      return null;
    }
  }

  //Metodo para iniciar sesion o registrarse con Facebook.

  // Future<UserCredential?> authFacebook() async {
  //   try {
  //     ///Se inicia la instancia para que el usuario inicie sesion con facebook
  //     final LoginResult loginwithFacebook = await FacebookAuth.instance.login();

  //     ///Se agregan las credenciales obtenidas en firebase console
  //     final OAuthCredential facebookCredentials =
  //         FacebookAuthProvider.credential(loginwithFacebook.accessToken!.token);

  //     ///Se regresan las credenciales para su posterior uso
  //     return FirebaseAuth.instance.signInWithCredential(facebookCredentials);
  //   } catch (error) {
  //     if (kDebugMode) {
  //       print("Error en el inicio de sesión con Facebook: $error");
  //     }
  //     return null;
  //   }
  // }

  //Metodo para iniciar sesion o registrarse Apple
  RxString nombre = ''.obs;
  RxString apellido = ''.obs;
  Future<UserCredential?> authApple() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      ///Se lanza la vista para que el usuario inicie sesion
      ///con su apple id, se recupera su nombre y correo.
      final result = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ], nonce: nonce);

      ///Las credenciales obtenidas se registran en firebase console,
      ///propocionando el identity Token del resultado del inicio de
      ///sesion
      ///

      nombre.value = result.givenName.toString();
      apellido.value = result.familyName.toString();
      // print(nombre.value);
      final AuthCredential appleAuthCredential =
          OAuthProvider('apple.com').credential(
        idToken: result.identityToken,
        rawNonce: Platform.isIOS ? rawNonce : null,
        // accessToken: Platform.isIOS ? null : result.authorizationCode,
      );

      // print(appleAuthCredential);

      ///Se regresan las credenciales para su posterior uso
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(appleAuthCredential);
      return userCredential;
    } catch (error) {
      if (kDebugMode) {
        print('Error al iniciar sesion con apple: $error');
      }
      return null;
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
