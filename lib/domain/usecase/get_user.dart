import 'package:dartz/dartz.dart';
import 'package:km_app_test/common/failure.dart';
import 'package:km_app_test/domain/entities/user.dart';
import 'package:km_app_test/domain/repositories/user_repository.dart';

class GetUser {
  final UserRepository repository;

  GetUser(this.repository);

  Future<Either<Failure, UserRequest>> execute(int page) {
    return repository.getUser(page);
  }
}
