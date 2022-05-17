// ignore_for_file: constant_identifier_names, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrms_app/models/login.dart';
import 'package:hrms_app/utils/shared_preference.dart';
import 'package:hrms_app/services/http_service.dart';
import 'package:http/http.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class LoginProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> result;
    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await HttpService.postAPI(
        '/api/sign-in-tenant', {"email": email, "password": password});

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      Login authUser = Login.fromJson(responseData);
      UserPreferences().saveLogin(authUser);
      _loggedInStatus = Status.LoggedIn;
      notifyListeners();
      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }

    return result;
  }

  static onError(error) {
    print('the error is ${error.detail}');
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
