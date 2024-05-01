import 'package:flutter_bloc_clean_architecture/core/error/failures.dart';
import 'package:flutter_bloc_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_bloc_clean_architecture/core/entities/user.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUserUseCase implements UseCase<User, NoParams>{
  final AuthRepo authRepo;

  CurrentUserUseCase(this.authRepo);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
   return await authRepo.currentUser();
  }

}

