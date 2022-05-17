// ignore_for_file: constant_identifier_names, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrms_app/models/user.dart';
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

class GetMeProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> getMe(String tenantId, String company) async {
    Map<String, dynamic> result;
    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await HttpService.postAPI(
        '/api/usermap/get-current-user',
        {"tenantId": tenantId, "company": company});

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      User authUser = User.fromJson(responseData);
      UserPreferences().saveUser(authUser);
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
