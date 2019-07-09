import 'package:flutter/material.dart';
import 'package:yek_nahal/widgets/YeNahal.dart';

import '../page_auth.dart';

class RegEmailPage extends StatefulWidget {

  Function _login;
  Function _setEmail;
  RegEmailPage(this._login, this._setEmail);

  @override
  State<StatefulWidget> createState() {
    return _RegEmailPage();
  }
}

class _RegEmailPage extends State<RegEmailPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Map _formData = {
    'email': '',
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
                              'جهت ثبت نام در یک نهال, آدرس ایمیل خود را وارد نمایید.',
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
                            style: TextStyle(fontFamily: ''),
                            decoration: InputDecoration(
                              labelText: 'ایمیل',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String value) {
                              _formData['email'] = value;
                            },
                            onFieldSubmitted: (String value){
                              _formData['email'] = value;
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
                                  widget._setEmail(_formData['email']);
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
        ),
      ),
    );
  }
}
