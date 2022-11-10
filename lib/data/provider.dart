import 'package:flutter/cupertino.dart';

class Options with ChangeNotifier {
  //Profile Credentials
  String _username = '';
  String _email = '';
  String _password = '';
  TextEditingController _emailLogin = TextEditingController();
  TextEditingController _passwordLogin = TextEditingController();
  int _id = 0;
  bool _credentials = false;

  String get username => _username;
  String get email => _email;
  String get password => _password;
  dynamic get emailLogin => _emailLogin;
  dynamic get passwordLogin => _passwordLogin;
  int get id => _id;
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

  TextEditingController changeEmailLogin(TextEditingController value){
    _emailLogin = value;
    return _emailLogin;
  }

  TextEditingController changePasswordLogin(TextEditingController value){
    _passwordLogin = value;
    return _passwordLogin;
  }

  void changeId(int value) {
    _id = value;
  }

  void changeCredentialsMatch() {
    _credentials = !_credentials;
  }

  //Profile Datas
  double _credits = 0;
  int _onWay = 0;
  int _points = 0;

  double get credits => _credits;
  int get onWay => _onWay;
  int get points => _points;

  void changeCredits(double value) {
    _credits = value;
  }

  void changeOnWay(int value) {
    _onWay = value;
  }

  void changePoints(int value) {
    _points = value;
  }

  //Configuration
  bool _notifications = false;

  bool get notifications => _notifications;

  void changeNotifications() {
    _notifications = !_notifications;
    notifyListeners();
  }
}
