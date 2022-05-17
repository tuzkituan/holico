import 'package:hrms_app/models/login.dart';
import 'package:hrms_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveLogin(Login login) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('id', login.id);
    prefs.setString('email', login.email);
    prefs.setString('token', login.token);
    prefs.setString('name', login.name);
    prefs.setString('tenantId', login.tenantId);
    prefs.setString('company', login.company);

    return prefs.commit();
  }

  Future<Login> getLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String id = prefs.getString("_id") ?? "";
    String email = prefs.getString("email") ?? "";
    String token = prefs.getString("token") ?? "";
    String name = prefs.getString("name") ?? "";
    String tenantId = prefs.getString("tenantId") ?? "";
    String company = prefs.getString("company") ?? "";

    return Login(
      id: id,
      email: email,
      token: token,
      name: name,
      tenantId: tenantId,
      company: company,
    );
  }

  void removeLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('id');
    prefs.remove('email');
    prefs.remove('token');
    prefs.remove('name');
    prefs.remove('tenantId');
    prefs.remove('company');
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? "";
  }

  // fetch me

  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('id', user.id);
    prefs.setString('email', user.email);
    prefs.setString('employeeId', user.employeeId);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String id = prefs.getString("_id") ?? "";
    String email = prefs.getString("email") ?? "";
    String employeeId = prefs.getString("employeeId") ?? "";

    return User(
      id: id,
      email: email,
      employeeId: employeeId,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('id');
    prefs.remove('email');
    prefs.remove('tenantId');
  }
}
