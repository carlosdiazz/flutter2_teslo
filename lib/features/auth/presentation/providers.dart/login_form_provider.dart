//! 1-  State de este provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/shared/infrastructure/inouts/inputs.dart';

//! 3- StateNotifierProvider - COnsume de afuera
final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier();
});

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  LoginFormState copyWith(
          {bool? isPosting,
          bool? isFormPosted,
          Email? email,
          Password? password,
          bool? isValid}) =>
      LoginFormState(
          email: email ?? this.email,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isPosting: isPosting ?? this.isPosting,
          password: password ?? this.password,
          isValid: isValid ?? this.isValid);

  @override
  String toString() {
    // TODO: implement toString
    print(email.value);
    return """
      LOGINFORMSTATE:
         isPosting: $isPosting
         isFOrmPosted: $isFormPosted
         email: ${email.value}
         password: ${password.value}
         isValid: $isValid
    """;
  }
}

//! 2- Implementar un Notifier
class LoginFormNotifier extends StateNotifier<LoginFormState> {
  //Aqui creo una Instancia por primera vez
  LoginFormNotifier() : super(LoginFormState());

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail, isValid: Formz.validate([newEmail, state.password]));
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.email]));
  }

  onFormSubmit() {
    _touchEveryField();
    if (!state.isValid) return;
    print(state);
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        isValid: Formz.validate([email, password]));
  }
}
