import 'package:flutter/material.dart';
import 'package:km_app_test/common/state_enum.dart';
import 'package:km_app_test/domain/entities/user.dart';
import 'package:km_app_test/domain/usecase/get_user.dart';

class UserListNotifier extends ChangeNotifier {
  final GetUser getUser;

  UserListNotifier(this.getUser);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  UserRequest? _userRequest;
  UserRequest? get userRequest => _userRequest;

  List<Data> _users = [];
  List<Data> get users => _users;

  String _message = '';
  String get message => _message;

  Future<void> fetchUser(int page) async {
    _state = RequestState.Loading;
    _currentPage = page;
    notifyListeners();

    final result = await getUser.execute(page);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (userRequest) {
        _userRequest = userRequest;
        _users = userRequest.data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchMoreUser() async {
    if (userRequest != null && userRequest!.totalPages <= _currentPage) {
      return;
    }

    _currentPage++;
    final result = await getUser.execute(_currentPage);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (userRequest) {
        _users.addAll(userRequest.data);
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
