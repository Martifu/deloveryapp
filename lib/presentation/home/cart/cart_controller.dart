import 'package:deliveryapp/domain/model/product.dart';
import 'package:deliveryapp/presentation/home/products/product_cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<ProductCart> cartList = <ProductCart>[].obs;
  RxInt totalItems = 0.obs;
  RxDouble totalPrice = 0.0.obs;

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
    cartList.assignAll(List<ProductCart>.from(temp));

    final total =
        temp.fold(0, (previousValue, element) => element.qty + previousValue);
    totalItems(total);
    calculateTotals(temp);
  }

  void increment(ProductCart productCart) {
    productCart.qty += 1;
    cartList.assignAll(List<ProductCart>.from(cartList));
    calculateTotals(cartList);
  }

  void decrement(ProductCart productCart) {
    if (productCart.qty > 1) {
      productCart.qty -= 1;
      cartList.assignAll(List<ProductCart>.from(cartList));
      calculateTotals(cartList);
    }
  }

  void calculateTotals(List<ProductCart> temp) {
    final total =
        temp.fold(0, (previousValue, element) => element.qty + previousValue);
    totalItems(total);
    final totalCost = temp.fold(
      0.0,
      (previousValue, element) =>
          (element.qty * element.product.price) + previousValue,
    );
    totalPrice(totalCost);
  }

  void deleteProduct(ProductCart product) {
    cartList.remove(product);
    calculateTotals(cartList);
  }
}
