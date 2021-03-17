import 'package:deliveryapp/domain/model/product.dart';
import 'package:deliveryapp/domain/repository/api_repository.dart';
import 'package:flutter/cupertino.dart';

class ProductsBLoC extends ChangeNotifier {
  final ApiRepositoryInterface apiRepositoryInterface;

  ProductsBLoC({this.apiRepositoryInterface});

  List<Product> productsList = <Product>[];

  void loadProducts() async {
    final result = await apiRepositoryInterface.getProducts();
    productsList = result;
    notifyListeners();
  }
}
