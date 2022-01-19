import 'package:flutter/material.dart';

class SelectedUserNotifier extends ChangeNotifier {
  String _selectedUser = 'Selected User Name';
  String get selectedUser => _selectedUser;

  setSelectedUser(String name) {
    _selectedUser = name;
    notifyListeners();
  }
}
