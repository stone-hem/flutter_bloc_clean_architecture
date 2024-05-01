import 'package:flutter_bloc_clean_architecture/core/error/failures.dart';
import 'package:flutter_bloc_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_bloc_clean_architecture/core/entities/user.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserLoginUseCase implements UseCase<User,UserLoginParams>{
  final AuthRepo authRepo;

  const UserLoginUseCase(this.authRepo);
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async{
    return await authRepo.loginWithEmailAndPassword(email: params.email, password: params.password);
  }

}

class UserLoginParams{
  final String email;
  final String password;
  UserLoginParams({required this.email, required this.password});
}