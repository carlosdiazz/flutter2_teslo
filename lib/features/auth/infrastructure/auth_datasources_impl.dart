// El dataSoruce, es eque tiene la conecion y la implementacion cpn el backend

import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/auth/infrastructure/user_mapper.dart';

import 'package:teslo_shop/features/auth/domain/domain.dart';

import 'auth_errors.dart';

class AuthDataSourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(baseUrl: Enviroment.apiUrl));

  @override
  Future<User> checkAuthStatus(String token) async {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio
          .post("/auth/login", data: {"email": email, "password": password});

      final user = UserMapper.userJsonToEntity(response.data);
      //print("Hizo login => ${user.token}");
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            e.response?.data["message"] ?? "Crendeciales Incorrectas");
      }

      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError(
            e.response?.data["message"] ?? "Revisar Conexion a Internet");
      }
      throw CustomError(
        "Error Desconocido Grave DIO",
      );
    } catch (e) {
      throw CustomError(
        "Error Desconocido GRAVE",
      );
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) async {
    // TODO: implement register
    throw UnimplementedError();
  }
}
