import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/models/auth_response.dart';
import 'package:yek_nahal/utils/routs.dart';
import 'package:yek_nahal/utils/utils.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPage();
  }
}

class _SplashPage extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    getToken().then((token){
      requestAuth(context, token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget child, MainScope model) {
        model.setStatusBar(Colors.teal);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Image.asset('assets/images/ic_logo.png'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  "یک نهال",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'IranSans',
                    fontWeight: FontWeight.w700,
                    color: Colors.teal,
                  ),
                ),
              ),
              Text(
                "#هدیه_به_زمین",
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future requestAuth(BuildContext context, String token) async {
    try {
      //token = "eyJ0eXAiOiJKV1QiLAogICAgICAgICAgICJhbGciOiJIUzI1NiJ9.ewogICAgICAgICAgICJlbWFpbCI6InNhbGVoLjc3MzRAZ21haWwuY29tIiwKICAgICAgICAgICAiZGF0ZSI6IjIwMTksMDcsMDgiCiAgICAgICAgICB9.EsBT1PGwQ4MTlK4orQG6Zj-BxzczT2fB2YlnPXucAsc";
      Map<String, String> header = {'Authorization': token};
      final http.Response response = await http.get(api_auth, headers: header);
      if (response.statusCode != 200 && response.statusCode != 201) {
        return false;
      } else {
        var result = json.decode(response.body);
        UserOb data;
        if (result['status'] == 200) {
          data = UserOb.fromJson(result['data']);
        } else {}
        Navigator.pushReplacementNamed(
          context,
          rout_main,
          arguments: data,
        );
        return true;
      }
    } catch (error) {
      return false;
    }
  }

  Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(shared_token) ?? "";
  }

}
