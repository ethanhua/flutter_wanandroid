import 'dart:convert';

import 'datasource/data_repository.dart';
import 'datasource/model/user.dart';
import 'utils/sp_utils.dart';

class AccountManager {
  factory AccountManager() => _getInstance();

  static AccountManager get instance => _getInstance();

  static AccountManager _instance;

  AccountManager._internal() {
    loadUserDataFromLocal();
  }

  static AccountManager _getInstance() {
    if (_instance == null) {
      _instance = new AccountManager._internal();
    }
    return _instance;
  }

  User _user;

  User getUser() {
    if (_user == null) {
      loadUserDataFromLocal();
    }
    return _user;
  }

  void loadUserDataFromLocal() {
    SpUtils.get(User.KEY_USER, (userStr) {
      if (userStr != null && userStr is String && userStr.isNotEmpty) {
        print("load user:" + userStr);
        _user = User.fromJson(jsonDecode(userStr));
      }
    });
  }

  bool isLogin() {
    getUser();
    return _user != null &&
        (_user.cookieExpireTime?.isAfter(DateTime.now()) ?? false);
  }

  String getCookie() {
    return _user?.cookie ?? "";
  }

  Future<User> login(String userName, String password) {
    return DataRepository().login(userName, password).then((user) {
      print("login return${user.username}");
      _user = user;
      _updateUser();
    });
  }

  Future<User> register(String userName, String password) {
    return DataRepository().register(userName, password).then((user) {
      print("register return" + user.username);
      _user = user;
      _updateUser();
    });
  }

  void logout() {
    _user = null;
    _updateUser();
  }

  void _updateUser({User user}) {
    if (user != null) {
      _user = user;
    }
    var userStr = _user != null ? jsonEncode(_user.toJson()) : "";
    print("put user:" + userStr);
    SpUtils.put(User.KEY_USER, userStr);
  }
}
