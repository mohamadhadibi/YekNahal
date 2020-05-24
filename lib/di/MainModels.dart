import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/subjects.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yek_nahal/models/auth_response.dart';
import 'package:yek_nahal/models/forget_password_response.dart';
import 'package:yek_nahal/models/login_response.dart';
import 'package:yek_nahal/pages/page_auth.dart';
import 'package:yek_nahal/utils/utils.dart';
import 'package:http/http.dart' as http;

mixin MainModel on Model {

  String token = "";
  void setToken(String token){
    this.token = token;
  }
  String getToken() => token;

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
  UserOb user;
  void setUser(UserOb user) {
    this.user = user;
  }
  UserOb getUser() => user;

  PageState pageState;
  void setPageState(PageState pageState){
    this.pageState = pageState;
  }
  PageState getPageState(){
    if(this.pageState == null){
      return PageState.reg_email;
    }else{
      return this.pageState;
    }
  }

  Future<LoginResponse> requestLogin(Map params) async {
    LoginResponse loginResult = LoginResponse();
    try {
      final http.Response response = await http.post(api_login, body: params);
      if (response.statusCode != 200 && response.statusCode != 201) {
        return loginResult;
      } else {
        var result = json.decode(response.body);
        LoginOb ob = (result['data'] != "") ? LoginOb.fromJson(result['data']) : null;
        loginResult = LoginResponse(status: result['status'], message: result['message'], data: ob);
        return loginResult;
      }
    } catch (error) {
      return loginResult;
    }
  }

  Future<ForgetPasswordResponse> requestForgetPassword(Map params) async {
    ForgetPasswordResponse forgetResult = new ForgetPasswordResponse();
    try {
      final http.Response response = await http.post(api_login, body: params);
      if (response.statusCode != 200 && response.statusCode != 201) {
        return forgetResult;
      } else {
        var result = json.decode(response.body);
        return forgetResult = ForgetPasswordResponse.fromJson(result);
      }
    } catch (error) {
      return forgetResult;
    }
  }

  Future<bool> logout() async{
    token = '';
    setUser(null);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(shared_token, token);
    return true;
  }

}

mixin SharedModel on MainModel {
  Future<bool> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(shared_token, token);
    return true;
  }
}

mixin NahalShopModel on MainModel {





}
