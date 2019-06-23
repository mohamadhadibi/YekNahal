import 'package:flutter/material.dart';
import 'package:yek_nahal/pages/auth/widget_cheange_password.dart';
import 'package:yek_nahal/pages/auth/widget_forget_password.dart';
import 'package:yek_nahal/pages/auth/widget_login.dart';
import 'package:yek_nahal/pages/auth/widget_reg_email.dart';
import 'package:yek_nahal/pages/auth/widget_reg_password.dart';

class AuthPage extends StatefulWidget {

  PageState pageState;

  AuthPage(this.pageState);

  @override
  State<StatefulWidget> createState() {
    return _AuthPage();
  }
}

class _AuthPage extends State<AuthPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: getView(),
      ),
    );
  }

  Widget getView() {
    Widget view = Container();
    switch (widget.pageState) {
      case PageState.login:
        view = LoginPage();
        break;
      case PageState.reg_email:
        view = RegEmailPage();
        break;
      case PageState.reg_password:
        view = RegPasswordPage();
        break;
      case PageState.change_password:
        view = ChangePasswordPage();
        break;
      case PageState.forget_password:
        view = ForgetPasswordPage();
        break;
      default:
        break;
    }

    return view;
  }
}

enum PageState {
  login,
  reg_email,
  reg_password,
  change_password,
  forget_password
}
