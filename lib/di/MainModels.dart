import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/subjects.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yek_nahal/models/login_response.dart';
import 'package:yek_nahal/utils/utils.dart';
import 'package:http/http.dart' as http;

mixin MainModel on Model {
  PublishSubject<bool> _loaderSubject = PublishSubject();

  void changeLoadingStatus(bool isLoading) {
    _loaderSubject.add(isLoading);
    notifyListeners();
  }

  void setStatusBar(Color color) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: color, //or set color with: Color(0xFF0000FF)
    ));
  }
}

mixin LoadingModel on MainModel {
  PublishSubject<bool> get loaderSubject {
    return _loaderSubject;
  }
}

mixin AuthModel on MainModel {

  Future<LoginResponse> requestLogin(Map params) async {
    LoginResponse loginResult = LoginResponse(status: 900, message: 'خطا', data: null);
    try {
      final http.Response response = await http
          .post(api_login, body: params);
      if (response.statusCode != 200 && response.statusCode != 201) {
        return loginResult;
      } else {
        var result = json.decode(response.body);
        loginResult = LoginResponse.fromJson(result);
        return loginResult;
      }
    } catch (error) {
      return loginResult;
    }
  }


}

mixin SharedModel on MainModel {

  Future<bool> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(shared_token, token);
    return true;
  }

}
