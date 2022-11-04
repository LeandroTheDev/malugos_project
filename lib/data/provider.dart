import 'package:flutter/cupertino.dart';

class Options with ChangeNotifier {
  bool _rememberMe = false;

  //Profile Datas
  String _username = '';
  String _email = '';
  String _password = '';
  bool _credentials = false;

  bool get rememberMe => _rememberMe;

  String get username => _username;
  String get email => _email;
  String get password => _password;
  bool get credentials => _credentials;

  void changeRememberMe() {
    _rememberMe = !rememberMe;
    notifyListeners();
  }

  void changeUserName(String value) {
    _username = value;
  }

  void changeUserEmail(String value) {
    _email = value;
  }

  void changeUserPassword(String value) {
    _password = value;
  }

  void changeCredentialsMatch() {
    _credentials = !_credentials;
  }
}
