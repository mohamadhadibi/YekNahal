import 'package:flutter/material.dart';
import 'package:yek_nahal/widgets/YeNahal.dart';

class ChangePasswordPage extends StatefulWidget {
  Function _changePageState;

  ChangePasswordPage(this._changePageState);

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordPage();
  }
}

class _ChangePasswordPage extends State<ChangePasswordPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Map _formData = {
    'password': '',
    'confirm': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Card(
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
                              'تغییر کلمه عبور \n رمز عبور جدید خود را وارد کنید!',
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
                              labelText: 'کلمه عبور',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            obscureText: true,
                            onSaved: (String value) {
                              _formData['password'] = value;
                            },
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'تکرار کلمه عبور',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            obscureText: true,
                            onSaved: (String value) {
                              _formData['confirm'] = value;
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
        ),
      ),
    );
  }
}
