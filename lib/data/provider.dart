import 'package:flutter/cupertino.dart';

class Options with ChangeNotifier {
  //Profile Datas
  String _username = '';
  String _email = '';
  String _password = '';
  bool _credentials = false;

  String get username => _username;
  String get email => _email;
  String get password => _password;
  bool get credentials => _credentials;

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

  //Configuration
  bool _notifications = false;

  bool get notifications => _notifications;

  void changeNotifications() {
    _notifications = !_notifications;
    notifyListeners();
  }
}
