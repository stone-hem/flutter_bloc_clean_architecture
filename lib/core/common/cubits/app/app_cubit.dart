import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/entities/user.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  void updateUser(User? user){
    if(user==null){
      emit(AppInitial());
    }else{
      emit(AppLoggedIn(user));
    }
  }
}
