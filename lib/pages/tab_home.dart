import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainScope.dart';
//import 'package:flutter_hooks/flutter_hooks.dart';
//import 'package:functional_widget_annotation/functional_widget_annotation.dart';

class HomeTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeTab();
  }
}

class _HomeTab extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget parent, MainScope model) {
        return Column(
          children: <Widget>[
            Container(
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  Image.asset('assets/images/ic_toolbar.png'),
                  mainCard(true),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(20),
              color: Colors.blue,
              elevation: 10,
              child: Text(
                'salam',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

//@hwidget
Widget mainCard(bool isLoggedIn) {
//  var state = useState(isLoggedIn);
  if (!isLoggedIn) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('ورود / ثبت‌نام'),
            subtitle: Column(children: <Widget>[
              Text(
                  'با عضویت در یک نهال خیلی راحت سفارش‌های خود را پیگیری کنید'),
              Row(
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      'عضویت',
                    ),
                    textColor: Colors.white,
                    color: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
//                      state.value = true;
                    },
                  ),
                ],
              )
            ]),
          ),
        ],
      ),
    );
  } else {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('نهال کاشتهٔ من'),
            subtitle: Row(children: <Widget>[Text("کاشته شده: ۵ نهال")]),
          ),
        ],
      ),
    );
  }
}
