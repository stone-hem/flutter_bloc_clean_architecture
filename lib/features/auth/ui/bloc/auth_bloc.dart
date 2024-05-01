import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/common/cubits/app/app_cubit.dart';
import 'package:flutter_bloc_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_bloc_clean_architecture/core/entities/user.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/user_register_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRegisterUseCase _userRegisterUseCase;
  final UserLoginUseCase _userLoginUseCase;
  final CurrentUserUseCase _currentUserUseCase;
  final AppCubit _appCubit;

  AuthBloc({
    required UserRegisterUseCase userRegisterUseCase,
    required UserLoginUseCase userLoginUseCase,
    required CurrentUserUseCase currentUserUseCase,
    required AppCubit appCubit,
  })  : _userRegisterUseCase = userRegisterUseCase,
        _userLoginUseCase = userLoginUseCase,
        _currentUserUseCase = currentUserUseCase,
        _appCubit = appCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_,emit)=>emit(AuthLoading()));
    on<AuthRegisterEvent>(_onAuthRegister);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthIsUserLoggedInEvent>(_onAuthIsUserLoggedIn);
  }

  void _onAuthIsUserLoggedIn(
      AuthIsUserLoggedInEvent event, Emitter<AuthState> emit) async {
    final res = await _currentUserUseCase(NoParams());
    res.fold((l) => emit(AuthFailure(l.message)),
        (user) => _onEmitAuthSuccess(user, emit));
  }

  void _onAuthRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    final res = await _userRegisterUseCase(UserRegisterParams(
      email: event.email,
      password: event.password,
      username: event.username,
    ));
    res.fold((l) => emit(AuthFailure(l.message)),
        (user) => _onEmitAuthSuccess(user, emit));
  }

  void _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    final res = await _userLoginUseCase(UserLoginParams(
      email: event.email,
      password: event.password,
    ));
    res.fold((l) => emit(AuthFailure(l.message)),
        (user) => _onEmitAuthSuccess(user, emit));
  }

  void _onEmitAuthSuccess(User user, Emitter<AuthState> emit) async {
    _appCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
