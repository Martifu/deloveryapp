import 'package:deliveryapp/presentation/main_binding.dart';
import 'package:deliveryapp/presentation/routes/delivery_navigation.dart';
import 'package:deliveryapp/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      title: 'Delivery App',
      initialRoute: DeliveryRoutes.splash,
      getPages: DeliveryPages.pages,
      initialBinding: MainBinding(),
    );
  }
}
