import 'package:flutter/material.dart';
import 'package:yek_nahal/widgets/YeNahal.dart';

import '../page_auth.dart';

class ForgetPasswordPage extends StatefulWidget {

  Function _changePageState;
  ForgetPasswordPage(this._changePageState);

  @override
  State<StatefulWidget> createState() {
    return _ForgetPasswordPage();
  }
}

class _ForgetPasswordPage extends State<ForgetPasswordPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _email = '';

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
                                onSaved: (String value) {
                                  _email = value;
                                },
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
                                    onPressed: () {},
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
                  widget._changePageState(PageState.login);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

}
