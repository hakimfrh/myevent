import 'user.dart';

class UserController {
  static final UserController _instance = UserController._internal();

  factory UserController() {
    return _instance;
  }

  UserController._internal();

  User? _user;

  User? get user => _user;

  set user(User? user) {
    _user = user;
  }

  void clearUser() {
    _user = null;
  }
}