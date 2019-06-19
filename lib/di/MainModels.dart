import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/subjects.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yek_nahal/models/auth_response.dart';
import 'package:yek_nahal/utils/utils.dart';

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

  PublishSubject<AuthOb> _authSubject = PublishSubject();
  PublishSubject<AuthOb> get authSubject {
    return _authSubject;
  }

  void setAuth(AuthOb ob) {
    _authSubject.add(ob);
    notifyListeners();
  }

  Future requestAuth(String token) async {
    try {
      Map<String,String> header = {'Authorization':token};
      final http.Response response = await http.get(api_auth,headers: header);
      if (response.statusCode != 200 && response.statusCode != 201) {
        return false;
      } else {
        var result = json.decode(response.body);

        setAuth(AuthOb.fromJson(result));
        notifyListeners();

        return true;
      }
    } catch (error) {
      changeLoadingStatus(false);
      return false;
    }
  }

}

mixin SharedModel on MainModel {

  PublishSubject<String> _tokenSubject = PublishSubject();
  PublishSubject<String> get tokenSubject {
    getToken();
    return _tokenSubject;
  }

  void saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(shared_token, token);
  }

  Future getToken() async {
    String temToken = "eyJ0eXAiOiJKV1QiLAogImFsZyI6IkhTMjU2In0.ewogImVtYWlsIjoic2FsZWguNzczNEBnbWFpbC5jb20iLAogInVzZXJfcnlwZSI6ImFkbWluIgp9.A4fdZ9MmIloP2NyBVAfUPEpXMl3JBPC5q5NTwcopy2w";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _tokenSubject.add(prefs.getString(shared_token) ?? "");
  }

}
