import 'package:flutter_bloc_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_bloc_clean_architecture/core/error/failures.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/data/sources/auth_remote_sources.dart';
import 'package:flutter_bloc_clean_architecture/core/entities/user.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  const AuthRepoImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authRemoteDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(response);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> registerWithEmailAndPassword({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final response = await authRemoteDataSource.registerWithEmailAndPassword(
        username: username,
        email: email,
        password: password,
      );
      return right(response);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final response = await authRemoteDataSource.getCurrentUserData();
      if(response==null){
        return left(Failure('user not logged in'));
      }
      return right(response);
    }  on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
