import 'package:teslo_shop/src/auth/domain/domain.dart';
import 'package:teslo_shop/src/auth/infrastructure/infrastrucuture.dart';

class AuthRepositotyImpl extends AuthRepository {
  final AuthDatasource datasource;
  //Aqui por defecto digo cual es la implemntacion de mi DataSource
  AuthRepositotyImpl({AuthDatasource? datasource})
      : datasource = datasource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) async {
    return datasource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    return datasource.register(email, password, fullName);
  }
}
