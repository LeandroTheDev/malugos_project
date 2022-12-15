import 'package:flutter/cupertino.dart';
import 'package:malugos_project/data/productsdata.dart';
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
  TextEditingController get emailLogin => _emailLogin;
  TextEditingController get passwordLogin => _passwordLogin;
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
  List<Product> _cartItems = [];
  double _credits = 0;
  int _onWay = 0;
  int _points = 0;

  List<Product> get cartItems => _cartItems;
  double get credits => _credits;
  int get onWay => _onWay;
  int get points => _points;

  void addCartItem(Product value) {
    _cartItems.add(value);
  }

  void removeSpecificCartItem(value) {
    if (value == 'last') {
      _cartItems.removeLast();
    } else {
      _cartItems.removeAt(value);
    }
    notifyListeners();
  }

  void removeAllCartItem() {
    _cartItems = [];
    notifyListeners();
  }

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
  bool _descMinimized = false;
  bool _notifications = false;
  bool _isLoading = false;
  String _sort = '';
  TextEditingController _roadName = TextEditingController();
  TextEditingController _roadNumber = TextEditingController();
  TextEditingController _roadState = TextEditingController();
  TextEditingController _roadDistrict = TextEditingController();
  TextEditingController _roadCEP = TextEditingController();
  TextEditingController _roadContact = TextEditingController();

  bool get descMinimized => _descMinimized;
  bool get notifications => _notifications;
  bool get isLoading => _isLoading;
  String get sort => _sort;
  TextEditingController get roadName => _roadName;
  TextEditingController get roadNumber => _roadNumber;
  TextEditingController get roadState => _roadState;
  TextEditingController get roadDistrict => _roadDistrict;
  TextEditingController get roadCEP => _roadCEP;
  TextEditingController get roadContact => _roadContact;

  void changeDescMinimaztion() {
    _descMinimized = !descMinimized;
    notifyListeners();
  }

  void changeNotifications() {
    _notifications = !_notifications;
    notifyListeners();
  }

  void changeIsLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void changeSort(sort) {
    _sort = sort;
    notifyListeners();
  }

  TextEditingController changeRoadName(TextEditingController value) {
    _roadName = value;
    return _roadName;
  }

  TextEditingController changeRoadNumber(TextEditingController value) {
    _roadNumber = value;
    return _roadNumber;
  }

  TextEditingController changeRoadState(TextEditingController value) {
    _roadState = value;
    return _roadState;
  }

  TextEditingController changeRoadDistrict(TextEditingController value) {
    _roadDistrict = value;
    return _roadDistrict;
  }

  TextEditingController changeRoadCEP(TextEditingController value) {
    _roadCEP = value;
    return _roadCEP;
  }

  TextEditingController changeRoadContact(TextEditingController value) {
    _roadContact = value;
    return _roadContact;
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
