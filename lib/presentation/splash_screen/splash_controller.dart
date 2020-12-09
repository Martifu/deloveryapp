import 'package:deliveryapp/domain/repository/api_repository.dart';
import 'package:deliveryapp/domain/repository/local_storage_repository.dart';
import 'package:deliveryapp/presentation/routes/delivery_navigation.dart';
import 'package:deliveryapp/presentation/theme.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  SplashController(
      {this.localRepositoryInterface, this.apiRepositoryInterface});

  @override
  void onReady() {
    validateSession();
    super.onReady();
  }

  @override
  void onInit() {
    validateTheme();
    super.onInit();
  }

  void validateTheme() async {
    final isDark = await localRepositoryInterface.isDarkMode();
    if (isDark != null) {
      Get.changeTheme(isDark ? darkTheme : lightTheme);
    } else {
      Get.changeTheme(Get.isDarkMode ? darkTheme : lightTheme);
    }
  }

  void validateSession() async {
    final token = await localRepositoryInterface.getToken();
    print(token);
    if (token != null) {
      final user = await apiRepositoryInterface.getUserFromToken(token);
      await localRepositoryInterface.saveUser(user);
      Get.offAllNamed(DeliveryRoutes.home);
    } else {
      Get.offNamed(DeliveryRoutes.login);
    }
  }
}
