import 'package:flutter/material.dart';
import 'package:yek_nahal/widgets/YeNahal.dart';

import '../page_auth.dart';

class RegPasswordPage extends StatefulWidget {
  Function _changePageState;
  Function _login;
  String _email;

  RegPasswordPage(this._changePageState, this._login, this._email);

  @override
  State<StatefulWidget> createState() {
    return _RegPasswordPage();
  }
}

class _RegPasswordPage extends State<RegPasswordPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Map _formData = {
    'email': '',
    'password': '',
  };

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
                                  'رمز عبور خود را وارد کنید.',
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
                                  if (value.isEmpty || value.length <= 3) {
                                    return 'کلمه عبور وارد شده معتبر نیست!';
                                  }
                                },
                                style: TextStyle(fontFamily: ''),
                                decoration: InputDecoration(
                                  labelText: 'کلمه عبور',
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                obscureText: true,
                                onSaved: (String value) {
                                  _formData['password'] = value;
                                },
                                onFieldSubmitted: (String value){
                                  _formData['password'] = value;
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
                                    onPressed: () {
                                      _formData['email'] = widget._email;
                                      widget._login(_formData);
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
                  'فراموشی کلمه عبور',
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                ),
                onPressed: () {
                  widget._changePageState(PageState.forget_password);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
