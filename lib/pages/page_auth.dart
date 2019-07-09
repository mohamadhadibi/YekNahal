import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/models/auth_response.dart';
import 'package:yek_nahal/models/login_response.dart';
import 'package:yek_nahal/pages/auth/widget_cheange_password.dart';
import 'package:yek_nahal/pages/auth/widget_forget_password.dart';
import 'package:yek_nahal/pages/auth/widget_login.dart';
import 'package:yek_nahal/pages/auth/widget_reg_email.dart';
import 'package:yek_nahal/pages/auth/widget_reg_password.dart';
import 'package:yek_nahal/utils/routs.dart';

class AuthPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _AuthPage();
  }
}

class _AuthPage extends State<AuthPage> {
  String _email = "";
  MainScope mainModel;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget parent, MainScope model) {
        this.mainModel = model;
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Container(
              alignment: AlignmentDirectional.center,
              margin: EdgeInsetsDirectional.only(end: 50),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
            backgroundColor: Colors.white,
          ),
          body: Container(
            child: getView(model),
          ),
        );
      },
    );
  }

  Widget getView(MainScope model) {
    Widget view = Container();
    switch (model.getPageState()) {
      case PageState.login:
        view = LoginPage(_changePageState, _login);
        break;
      case PageState.reg_email:
        view = RegEmailPage(_login, _setEmail);
        break;
      case PageState.reg_password:
        view = RegPasswordPage(_changePageState, _login, _email);
        break;
      case PageState.change_password:
        view = ChangePasswordPage(_changePageState);
        break;
      case PageState.forget_password:
        view = ForgetPasswordPage(_changePageState);
        break;
      default:
        break;
    }

    return view;
  }

  void _changePageState(PageState state) {
    setState(() {
      mainModel.setPageState(state);
    });
  }

  void _login(data) {
    this.mainModel.requestLogin(data).then((response) {
      if (response != null && response is LoginResponse) {
        switch (response.status) {
          case 200:
            /*user is registered before and verified*/
            _changePageState(PageState.reg_password);
            break;

          case 201:
            /*user ordered before but not verified*/
            _dialogHints('برای فعالسازی اکانت خود به ایمیلتان مراجعه کرده و بروی لینک فعالسازی کلیک کنید.');
            break;

          case 202:
            /*user password verified and login complete*/
            this.mainModel.saveToken(response.data.token).then((done) {
              UserOb user = UserOb(
                avatarUrl: response.data.avatarUrl,
                email: response.data.email,
                username: response.data.username,
                plantedNumber: response.data.plantedNumber,
                waitingPlantedNumber: response.data.waitingPlantedNumber,
              );
              Navigator.pushReplacementNamed(
                context,
                rout_main,
                arguments: user,
              );
            });
            break;

          case 400:
            _dialogHints('مشکلی رخ داده است, لطفا موارد خواسته شده را با دقت پر کرده و مجددا درخواست نمایید.');
            break;

          case 404:
            /*user not registered*/
            _dialogHints('لینک ثبتنام به ایمیل شما ارسال شد, لطفا به ایمیل خود مراجعه کرده و بروی لینک فعالسازی کلیک کنید.');
            break;

          default:
            //TODO: error handling needed , below code is fake
            _changePageState(PageState.reg_email);
            break;
        }
      }
    });
  }

  void _setEmail(String email) {
    debugPrint('email: $email');
    _email = email;
  }

  void _dialogHints(String message){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('توجه!!'),
          content: Text(message),
          actions: <Widget>[
            RaisedButton(
              child: Text('باشه'),
              onPressed: () {
                Navigator.pop(context);
                //Navigator.pop(context, true);
              },
              textColor: Colors.white,
              //color: Theme.of(context).primaryColor,
            ),
          ],
        );
      },
    );
  }

}

enum PageState {
  login,
  reg_email,
  reg_password,
  change_password,
  forget_password
}
