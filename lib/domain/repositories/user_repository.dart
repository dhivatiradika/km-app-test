import 'package:dartz/dartz.dart';
import 'package:km_app_test/common/failure.dart';
import 'package:km_app_test/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, UserRequest>> getUser(int page);
}
