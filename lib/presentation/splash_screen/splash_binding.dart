import 'package:deliveryapp/presentation/splash_screen/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    print('splash controller');
    Get.lazyPut(
      () => SplashController(
        apiRepositoryInterface: Get.find(),
        localRepositoryInterface: Get.find(),
      ),
    );
  }
}
