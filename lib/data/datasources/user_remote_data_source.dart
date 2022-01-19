import 'dart:convert';

import 'package:km_app_test/common/exception.dart';
import 'package:km_app_test/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserRequestModel> getUsers(int page);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  static const BASE_URL = 'https://reqres.in/api/users';

  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});
  @override
  Future<UserRequestModel> getUsers(int page) async {
    final response =
        await client.get(Uri.parse('$BASE_URL?page=$page&per_page=10'));
    if (response.statusCode == 200) {
      return UserRequestModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
