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
        child: getView(),
      ),
    );
  }

  Widget getView() {
    Widget view = Container();
    switch (widget.pageState) {
      case PageState.login:
        view = LoginPage(_changePageState);
        break;
      case PageState.reg_email:
        view = RegEmailPage(_changePageState);
        break;
      case PageState.reg_password:
        view = RegPasswordPage(_changePageState);
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

  void _changePageState(PageState state){
    setState(() {
      widget.pageState = state;
    });
  }
}

enum PageState {
  login,
  reg_email,
  reg_password,
  change_password,
  forget_password
}
