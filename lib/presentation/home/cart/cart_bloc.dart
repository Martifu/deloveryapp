import 'package:deliveryapp/domain/model/product.dart';
import 'package:deliveryapp/presentation/home/products/product_cart.dart';
import 'package:flutter/material.dart';

class CartBLoC extends ChangeNotifier {
  List<ProductCart> cartList = <ProductCart>[];
  int totalItems = 0;
  double totalPrice = 0.0;

  void add(Product product) {
    final temp = List<ProductCart>.from(cartList);
    bool found = false;
    for (ProductCart p in temp) {
      if (p.product.name == product.name) {
        p.qty += 1;
        found = true;
        break;
      }
    }
    if (!found) {
      temp.add(ProductCart(product: product));
    }
    cartList = List<ProductCart>.from(temp);
    calculateTotals(temp);
  }

  void increment(ProductCart productCart) {
    productCart.qty += 1;
    cartList = List<ProductCart>.from(cartList);
    calculateTotals(cartList);
  }

  void decrement(ProductCart productCart) {
    if (productCart.qty > 1) {
      productCart.qty -= 1;
      cartList = List<ProductCart>.from(cartList);
      calculateTotals(cartList);
    }
  }

  void calculateTotals(List<ProductCart> temp) {
    final total =
        temp.fold(0, (previousValue, element) => element.qty + previousValue);
    totalItems = total;
    final totalCost = temp.fold(
      0.0,
      (previousValue, element) =>
          (element.qty * element.product.price) + previousValue,
    );
    totalPrice = totalCost;
    notifyListeners();
  }

  void deleteProduct(ProductCart product) {
    cartList.remove(product);
    calculateTotals(cartList);
  }
}
