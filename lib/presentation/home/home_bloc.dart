import 'package:deliveryapp/domain/model/user.dart';
import 'package:deliveryapp/domain/repository/api_repository.dart';
import 'package:deliveryapp/domain/repository/local_storage_repository.dart';
import 'package:flutter/material.dart';

class HomeBLoC extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  HomeBLoC({this.localRepositoryInterface, this.apiRepositoryInterface});

  User user;
  int indexSelected = 0;

  void loadUser() async {
    user = await localRepositoryInterface.getUser();
    notifyListeners();
  }

  void updateSelectedndex(int index) {
    indexSelected = index;
    notifyListeners();
  }
}
