import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainScope.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(20),
                    color: Colors.blue,
                    elevation: 10,
                    child: Text('salam',style: TextStyle(color: Colors.black,),),
                  ),
                  Image.asset('assets/images/ic_toolbar.png'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
