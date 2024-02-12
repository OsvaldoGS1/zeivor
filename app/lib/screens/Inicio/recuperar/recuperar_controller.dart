import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecuperarController extends GetxController {
// final MyRepository repository;
// RecuperarController(this.repository);

//   final _obj = ''.obs;
//   set obj(value) => this._obj.value = value;
//   get obj => this._obj.value;

  RxBool isRecovery = false.obs;
  TextEditingController emailTextController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
}
