import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/widgets/Toolbar.dart';
import 'package:yek_nahal/widgets/YeNahal.dart';

class OurTeamPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OurTeamPage();
  }
}

class _OurTeamPage extends State<OurTeamPage> {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget parent, MainScope model) {
        return Scaffold(
          appBar: makeAppbar('تیم ما', context),
          body: Container(
            child: Container(
              child: Column(
                children: <Widget>[
                  YeNahal(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
