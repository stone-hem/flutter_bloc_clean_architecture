import 'package:flutter_bloc_clean_architecture/core/error/failures.dart';
import 'package:flutter_bloc_clean_architecture/core/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepo {
  Future<Either<Failure, User>> registerWithEmailAndPassword({
    required String email,
    required String username,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();
}
