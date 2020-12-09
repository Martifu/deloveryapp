import 'package:deliveryapp/presentation/splash_screen/splash_controller.dart';
import 'package:deliveryapp/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetWidget<SplashController> {
  final splashController = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: deliveryGradiants,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: DeliveryColors.white,
              radius: 50,
              child: FlutterLogo(),
            ),
            Text(
              'Delivery App',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3.copyWith(
                  fontWeight: FontWeight.bold, color: DeliveryColors.white),
            )
          ],
        ),
      ),
    );
  }
}
