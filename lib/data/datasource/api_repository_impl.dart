import 'package:deliveryapp/data/in_memory_products.dart';
import 'package:deliveryapp/domain/exception/auth_exception.dart';
import 'package:deliveryapp/domain/model/product.dart';
import 'package:deliveryapp/domain/model/user.dart';
import 'package:deliveryapp/domain/repository/api_repository.dart';
import 'package:deliveryapp/domain/response/login_response.dart';
import 'package:deliveryapp/domain/request/login_request.dart';

class ApiRepositoryImpl extends ApiRepositoryInterface {
  @override
  Future<User> getUserFromToken(String token) async {
    await Future.delayed(const Duration(seconds: 3));
    if (token == 'M777') {
      return User(
        name: 'Martin Esparza',
        username: 'martifu',
        image: 'assets/logo.png',
      );
    } else if (token == 'M333') {
      return User(
        name: 'Monserrat León',
        username: 'lamonse',
        image: 'assets/monse.jpg',
      );
    }

    throw AuthException();
  }

  @override
  Future<LoginResponse> login(LoginRequest login) async {
    await Future.delayed(const Duration(seconds: 3));

    if (login.username == 'martifu' && login.password == '1234567') {
      return LoginResponse(
        'M777',
        User(
          name: 'Martin Esparza',
          username: 'martifu',
          image: 'assets/logo.png',
        ),
      );
    } else if (login.username == 'lamonse' && login.password == '1234567') {
      return LoginResponse(
        'M333',
        User(
          name: 'Monserrat León',
          username: 'Lamonse',
          image: 'assets/monse.jpg',
        ),
      );
    }

    throw AuthException();
  }

  @override
  Future<void> logout(String token) async {
    print('Removnig token from server $token');
    return;
  }

  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return products;
  }
}
