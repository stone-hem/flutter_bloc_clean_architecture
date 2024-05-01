import 'package:flutter_bloc_clean_architecture/core/error/failures.dart';
import 'package:flutter_bloc_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_bloc_clean_architecture/core/entities/user.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserRegisterUseCase implements UseCase<User, UserRegisterParams> {
  final AuthRepo authRepo;

  const UserRegisterUseCase(this.authRepo);

  @override
  Future<Either<Failure, User>> call(UserRegisterParams params) async {
    return await authRepo.registerWithEmailAndPassword(
        email: params.email,
        username: params.username,
        password: params.password);
  }
}

class UserRegisterParams {
  final String email;
  final String password;
  final String username;
  UserRegisterParams(
      {required this.email, required this.password, required this.username});
}
