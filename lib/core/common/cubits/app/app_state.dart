part of 'app_cubit.dart';

@immutable
sealed class AppState {}

class AppInitial extends AppState {}

class AppLoggedIn extends AppState {
  final User user;

  AppLoggedIn(this.user);
}
