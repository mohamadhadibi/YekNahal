import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/models/auth_response.dart';
import 'package:yek_nahal/utils/routs.dart';
import 'package:yek_nahal/utils/utils.dart';
import 'package:http/http.dart' as http;

class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget child, MainScope model){
        model.setStatusBar(Colors.teal);
        //_setObserver(model, context);
        //model.requestAuth("");
        _getToken().then((token){
          if(token == null || token == ""){
            Navigator.pushReplacementNamed(
              context,
              rout_main,
            );
          }else{
            requestAuth(context, token);
          }
        });
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
                "هدیه_به_زمین#",
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
      Map<String,String> header = {'Authorization':token};
      final http.Response response = await http.get(api_auth,headers: header);
      if (response.statusCode != 200 && response.statusCode != 201) {
        return false;
      } else {
        var result = json.decode(response.body);

        if(result['status']==200){
          var data = UserOb.fromJson(result['data']);

        }else{

        }
        Navigator.pushReplacementNamed(
          context,
          rout_main,
        );
        return true;
      }
    } catch (error) {
      return false;
    }
  }

  void _setObserver(MainScope model, BuildContext context) async{

    model.authSubject.listen((AuthOb auth){
      if(auth!=null){
        if(auth.status==200){
          Navigator.pushReplacementNamed(
            context,
            rout_main,
          );
        }
      }
    });

    /*_tokenSubject.listen((String token){
      if(token!=null){
        model.requestAuth(token);
      }
    });*/
  }

  Future _getToken() async {
    String my_token = "eyJ0eXAiOiJKV1QiLAogImFsZyI6IkhTMjU2In0.ewogImVtYWlsIjoic2FsZWguNzczNEBnbWFpbC5jb20iLAogInVzZXJfcnlwZSI6ImFkbWluIgp9.A4fdZ9MmIloP2NyBVAfUPEpXMl3JBPC5q5NTwcopy2w";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(shared_token) ?? my_token;
  }
}
