import 'dart:io';

import 'package:km_app_test/common/exception.dart';
import 'package:km_app_test/data/datasources/user_remote_data_source.dart';
import 'package:km_app_test/domain/entities/user.dart';
import 'package:km_app_test/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:km_app_test/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserRequest>> getUser(int page) async {
    try {
      final result = await remoteDataSource.getUsers(page);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
