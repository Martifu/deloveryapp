import 'package:deliveryapp/presentation/home/cart/cart_controller.dart';
import 'package:deliveryapp/presentation/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        localRepositoryInterface: Get.find(),
        apiRepositoryInterface: Get.find(),
      ),
    );

    Get.lazyPut(
      () => CartController(),
    );
  }
}
