import 'package:deliveryapp/presentation/home/home_binding.dart';
import 'package:deliveryapp/presentation/home/home_screen.dart';
import 'package:deliveryapp/presentation/login/login_binding.dart';
import 'package:deliveryapp/presentation/login/login_screen.dart';
import 'package:deliveryapp/presentation/splash_screen/splash_binding.dart';
import 'package:deliveryapp/presentation/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

import '../main_binding.dart';

class DeliveryRoutes {
  static final String splash = '/splash';
  static final String login = '/login';
  static final String home = '/home';
}

class DeliveryPages {
  static final pages = [
    GetPage(
      name: DeliveryRoutes.splash,
      page: () => SplashScreen(),
      bindings: [MainBinding(), SplashBinding()],
    ),
    GetPage(
      name: DeliveryRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
        name: DeliveryRoutes.home,
        page: () => HomeScreen(),
        binding: HomeBinding()),
  ];
}
