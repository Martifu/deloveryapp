import 'package:deliveryapp/domain/repository/api_repository.dart';
import 'package:deliveryapp/domain/repository/local_storage_repository.dart';
import 'package:flutter/material.dart';

class SplashBLoC extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  SplashBLoC({
    this.localRepositoryInterface,
    this.apiRepositoryInterface,
  });

  /*void validateTheme() async {
    final isDark = await localRepositoryInterface.isDarkMode();
    if (isDark != null) {
      Get.changeTheme(isDark ? darkTheme : lightTheme);
    } else {
      Get.changeTheme(Get.isDarkMode ? darkTheme : lightTheme);
    }
  }*/

  Future<bool> validateSession() async {
    final token = await localRepositoryInterface.getToken();
    print(token);
    if (token != null) {
      final user = await apiRepositoryInterface.getUserFromToken(token);
      await localRepositoryInterface.saveUser(user);
      return true;
    } else {
      return false;
    }
  }
}
