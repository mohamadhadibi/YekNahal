import 'package:flutter/material.dart';
import 'package:yek_nahal/widgets/YeNahal.dart';

import '../page_auth.dart';

class ForgetPasswordPage extends StatefulWidget {

  Function _changePageState;
  Function _forgetPassword;
  String _email;
  ForgetPasswordPage(this._forgetPassword, this._changePageState, this._email);

  @override
  State<StatefulWidget> createState() {
    return _ForgetPasswordPage();
  }
}

class _ForgetPasswordPage extends State<ForgetPasswordPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 6,
                child: Column(
                  children: <Widget>[
                    YeNahal(),
                    Center(
                      child: Form(
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.all(30),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'فراموشی رمز عبور \n لطفا ایمیل خود را وارد کنید.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    height: 1.5,
                                  ),
                                ),
                                margin: EdgeInsets.only(top: 50),
                                alignment: AlignmentDirectional.center,
                              ),
                              TextFormField(
                                controller: _usernameController,
                                initialValue: widget._email,
                                validator: (String value) {
                                  if (value.isEmpty ||
                                      !RegExp(r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$')
                                          .hasMatch(value)) {
                                    return 'ایمیل وارد شده معتبر نیست!';
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'ایمیل',
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              Container(
                                margin: EdgeInsets.all(20),
                                child: ConstrainedBox(
                                  constraints:
                                  BoxConstraints(minWidth: double.infinity),
                                  child: RaisedButton(
                                    child: Text(
                                      'تایید',
                                    ),
                                    textColor: Colors.white,
                                    color: Colors.teal,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    onPressed: () {

                                      widget._email = _usernameController.text;
                                      Map _formData = {
                                        'email': widget._email,
                                      };
                                      widget._forgetPassword(_formData);
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                child: Text(
                  'ورود / ثبت نام',
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                ),
                onPressed: () {
                  widget._changePageState(PageState.reg_email);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

}
