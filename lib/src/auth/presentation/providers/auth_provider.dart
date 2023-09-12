//Este archivo es que que tiene la implemntacion de neustro reposittio, el cual se conecta al DataSource Y nos permite llegar al Backend, el datasoruce es quien tiene la implementacion
//Nuestro provider es wuien llama a el Repository

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/src/auth/domain/auth_repository.dart';
import 'package:teslo_shop/src/auth/infrastructure/infrastrucuture.dart';
import 'package:teslo_shop/src/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:teslo_shop/src/shared/infrastructure/services/key_value_storage_service_impl.dart';

import '../../domain/auth_entity.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositotyImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
      authRepository: authRepository,
      keyValueStorageService: keyValueStorageService);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;
  AuthNotifier(
      {required this.authRepository, required this.keyValueStorageService})
      : super(AuthState()) {
    //Cuando se crea la primera instancia reviso el jwt
    chechAuthStatus();
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    //TODO borrar de aqui
    await Future.delayed(const Duration(milliseconds: 800));
    try {
      final user = await authRepository.login(email, password);
      _setLoggerUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout("Error no controlado");
    }

    //final user = await authRepository.login(email, password);
    //state = state.copyWith();
  }

  void registerUser(String email, String password, String fullName) async {}

  void chechAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>("token");
    if (token == null) return logout();
    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggerUser(user);
    } catch (e) {
      logout();
    }
  }

  Future<void> logout([String? errorMessage]) async {
    await keyValueStorageService.removeKey("token");
    //TODO: limpiar token
    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage);
  }

  Future<void> _setLoggerUser(User user) async {
    //TODo: necesito guardar el token en el dipositivo
    await keyValueStorageService.setKeyValue("token", user.token);
    state = state.copyWith(
      user: user,
      errorMessage: "",
      authStatus: AuthStatus.authenticated,
    );
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = ""});

  AuthState copyWith(
          {AuthStatus? authStatus, User? user, String? errorMessage}) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          errorMessage: errorMessage ?? this.errorMessage,
          user: user ?? this.user);
}
