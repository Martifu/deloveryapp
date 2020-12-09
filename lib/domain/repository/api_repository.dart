import 'package:deliveryapp/domain/model/product.dart';
import 'package:deliveryapp/domain/model/user.dart';
import 'package:deliveryapp/domain/request/login_request.dart';
import 'package:deliveryapp/domain/response/login_response.dart';

abstract class ApiRepositoryInterface {
  Future<User> getUserFromToken(String token);
  Future<LoginResponse> login(LoginRequest login);
  Future<void> logout(String token);
  Future<List<Product>> getProducts();
}
