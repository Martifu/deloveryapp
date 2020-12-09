import 'package:deliveryapp/domain/model/user.dart';

class LoginResponse {
  final String token;
  final User user;

  const LoginResponse(this.token, this.user);
}
