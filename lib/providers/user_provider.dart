import 'package:flutter/cupertino.dart';
import 'package:hrms_app/models/login.dart';
import 'package:hrms_app/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = const User(id: '', email: '', employeeId: '');
  Login _login = const Login(
      id: "", email: "", token: "", name: "", tenantId: "", company: "");

  User get user => _user;
  Login get login => _login;

  void setUser(User user) {
    _user = user;
    // notifyListeners();
  }

  void setLogin(Login login) {
    _login = login;
    // notifyListeners();
  }
}
