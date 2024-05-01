import 'package:flutter_bloc_clean_architecture/core/common/cubits/app/app_cubit.dart';
import 'package:flutter_bloc_clean_architecture/core/secrets/app_secrets.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/data/repo/auth_repo_impl.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/data/sources/auth_remote_sources.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/repo/auth_repo.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/usecases/user_register_usecase.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/ui/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final supabaseClient = await Supabase.initialize(
      url: AppSecrets.supaBaseUrl, anonKey: AppSecrets.supaBaseAnonKey);
  sl.registerLazySingleton(() => supabaseClient.client);
  sl.registerLazySingleton(() => AppCubit());
  _initAuth();

}

void _initAuth() {
  sl.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      sl<SupabaseClient>(),
    ),
  );
  sl.registerFactory<AuthRepo>(() => AuthRepoImpl(sl()));
  sl.registerFactory(() => UserRegisterUseCase(sl()));
  sl.registerFactory(() => UserLoginUseCase(sl()));
  sl.registerFactory(() => CurrentUserUseCase(sl()));
  sl.registerLazySingleton(
    () => AuthBloc(
      userRegisterUseCase: sl(),
      userLoginUseCase: sl(),
      currentUserUseCase: sl(),
      appCubit: sl(),
    ),
  );
}
