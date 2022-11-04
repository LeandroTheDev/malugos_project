import 'package:flutter/cupertino.dart';

class Options with ChangeNotifier {
  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  void changeRememberMe() {
    _rememberMe = !rememberMe;
    notifyListeners();
  }
}