import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/subjects.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

mixin SharedModel on MainModel {

  void saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(shared_token, token);
  }

}
