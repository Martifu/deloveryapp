import 'package:deliveryapp/domain/model/product.dart';

class ProductCart {
  final Product product;
  int qty;

  ProductCart({this.product, this.qty = 1});
}
