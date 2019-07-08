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
  PageState pageState;

  AuthPage(this.pageState);

  @override
  State<StatefulWidget> createState() {
    return _AuthPage();
  }
}

class _AuthPage extends State<AuthPage> {
  MainScope model;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget parent, MainScope model) {
        this.model = model;
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
      },
    );
  }

  Widget getView() {
    Widget view = Container();
    switch (widget.pageState) {
      case PageState.login:
        view = LoginPage(_changePageState, _login);
        break;
      case PageState.reg_email:
        view = RegEmailPage(_changePageState);
        break;
      case PageState.reg_password:
        view = RegPasswordPage(_changePageState, _login, '');
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
      widget.pageState = state;
    });
  }

  void _login(data) {
    this.model.requestLogin(data).then((response) {
      if (response != null && response is LoginResponse) {
        debugPrint('result: ${response.toString()}');
        switch (response.status) {
          case 200:
            this.model.saveToken(response.data.token).then((done) {
              UserOb user = UserOb(
                isValid: true,
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

          default:
            //TODO: error handling needed , below code is fake
            _changePageState(PageState.reg_email);
            break;
        }
      }
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
