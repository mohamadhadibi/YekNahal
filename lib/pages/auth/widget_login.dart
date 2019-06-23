import 'package:flutter/material.dart';
import 'package:yek_nahal/widgets/YeNahal.dart';

import '../page_auth.dart';

class LoginPage extends StatefulWidget {

  Function _changePageState;
  LoginPage(this._changePageState);

  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Map _formData = {
    'username': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(children: <Widget>[
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
                                'لطفا اطلاعات خواسته شده را وارد کنید.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  height: 1.5,
                                ),
                              ),
                              margin: EdgeInsets.only(top: 50),
                              alignment: AlignmentDirectional.center,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'نام کاربری',
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              keyboardType: TextInputType.text,
                              onSaved: (String value) {
                                _formData['username'] = value;
                              },
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'کلمه عبور',
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              obscureText: true,
                              onSaved: (String value) {
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
                                    'ورود',
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
                'ثبت نام',
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
              onPressed: () {
                widget._changePageState(PageState.reg_email);
              },
            )
          ],)
        ),
      ),
    );
  }
}
