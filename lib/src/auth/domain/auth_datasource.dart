//Es la deficinicion de como queiro que sean los sitema de autenticacion
import 'domain.dart';

abstract class AuthDatasource {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String fullName);
  Future<User> checkAuthStatus(String token);
}
