part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;

  AuthRegisterEvent({
    required this.email,
    required this.password,
    required this.username,
  });
}

final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent({
    required this.email,
    required this.password,
  });
}

final class AuthIsUserLoggedInEvent extends AuthEvent {

}
