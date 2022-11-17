import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Options with ChangeNotifier {
  //Profile Credentials
  String _username = '';
  String _email = '';
  String _password = '';
  TextEditingController _emailLogin = TextEditingController();
  TextEditingController _passwordLogin = TextEditingController();
  int _id = 0;
  bool _rememberLogin = false;
  bool _credentials = false;

  String get username => _username;
  String get email => _email;
  String get password => _password;
  dynamic get emailLogin => _emailLogin;
  dynamic get passwordLogin => _passwordLogin;
  int get id => _id;
  bool get rememberLogin => _rememberLogin;
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

  TextEditingController changeEmailLogin(TextEditingController value) {
    _emailLogin = value;
    return _emailLogin;
  }

  TextEditingController changePasswordLogin(TextEditingController value) {
    _passwordLogin = value;
    return _passwordLogin;
  }

  void changeId(int value) {
    _id = value;
  }

  void changeRememberLogin() {
    _rememberLogin = !_rememberLogin;
    notifyListeners();
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
  bool _isLoading = false;
  String _featureCategory = 'Tudo';

  bool get notifications => _notifications;
  bool get isLoading => _isLoading;
  String get featureCategory => _featureCategory;

  void changeNotifications() {
    _notifications = !_notifications;
    notifyListeners();
  }

  void changeIsLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void changeFeatureCategory(String value) {
    _featureCategory = value;
    notifyListeners();
  }
}

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _email = 'email';
  static const _password = 'password';
  static const _username = 'username';
  static const _id = '0';
  static const _remember = 'false';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setEmail(String email) async {
    await _preferences.setString(_email, email);
  }

  static Future setPassword(String password) async {
    await _preferences.setString(_password, password);
  }

  static Future setUsername(String username) async {
    await _preferences.setString(_username, username);
  }

  static Future setId(int id) async {
    await _preferences.setInt(_id, id);
  }

  static Future setRemember(bool value) async {
    await _preferences.setBool(_remember, value);
  }

  static String? getEmail() => _preferences.getString(_email);
  static String? getPassword() => _preferences.getString(_password);
  static String? getUsername() => _preferences.getString(_username);
  static int? getId() => _preferences.getInt(_id);
  static bool? getRemember() => _preferences.getBool(_remember);
}
