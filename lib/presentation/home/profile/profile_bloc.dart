import 'package:deliveryapp/domain/repository/api_repository.dart';
import 'package:deliveryapp/domain/repository/local_storage_repository.dart';
import 'package:flutter/material.dart';

class ProfileBLoC extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  ProfileBLoC({this.localRepositoryInterface, this.apiRepositoryInterface});

  bool isDark;

  void loadCurrentTheme() async {
    isDark = await localRepositoryInterface.isDarkMode() ?? false;
    notifyListeners();
  }

  void updateTheme(bool isDarkValue) {
    localRepositoryInterface.saveDarkMode(isDark);
    isDark = isDarkValue;
    notifyListeners();
  }

  Future<void> logOut() async {
    final token = await localRepositoryInterface.getToken();
    await apiRepositoryInterface.logout(token);
    await localRepositoryInterface.clearAllData();
  }
}
