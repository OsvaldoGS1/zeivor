import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyController controller = Get.put(MyController());
    return Scaffold(
      body: Obx(
        () => Container(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: const Duration(seconds: 5),
              curve: Curves.bounceOut,
              width: !controller.isImageVisible.value
                  ? Get.width * 0.7
                  : Get.width * 0.35,
              height: !controller.isImageVisible.value
                  ? Get.width * 0.7
                  : Get.width * 0.35,
              child: Image.asset(
                'assets/images/logos/Logo_Oficial_ZEIVOR_vertical_principal.png',
                // width: Get.width * 0.6,
                fit: BoxFit.contain,
              ),
            )),
      ),
    );
  }
}

class MyController extends GetxController {
  RxBool isImageVisible = true.obs;
  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 50), () {
      isImageVisible.toggle();
    });
    super.onInit();
  }
}
