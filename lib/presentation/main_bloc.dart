import 'package:deliveryapp/domain/repository/local_storage_repository.dart';
import 'package:deliveryapp/presentation/theme.dart';
import 'package:flutter/material.dart';

class MainBLoC extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;

  MainBLoC({this.localRepositoryInterface});
  ThemeData currentTheme;

  void loadTheme() async {
    final isDark = await localRepositoryInterface.isDarkMode() ?? false;
    updateTheme(isDark ? darkTheme : lightTheme);
  }

  void updateTheme(ThemeData theme) {
    currentTheme = theme;
    notifyListeners();
  }
}
