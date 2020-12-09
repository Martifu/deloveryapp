import 'package:deliveryapp/domain/model/product.dart';
import 'package:deliveryapp/domain/repository/api_repository.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;

  ProductsController({this.apiRepositoryInterface});

  RxList<Product> productsList = <Product>[].obs;

  @override
  void onInit() {
    loadProducts();
    super.onInit();
  }

  void loadProducts() async {
    final result = await apiRepositoryInterface.getProducts();
    productsList.assignAll(result);
  }
}
