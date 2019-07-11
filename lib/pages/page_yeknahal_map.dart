import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainScope.dart';

class YekNahalMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _YekNahalMapPage();
  }
}

class _YekNahalMapPage extends State<YekNahalMapPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget parent, MainScope model) {
        return Container(color: Colors.lightBlueAccent,);
      },
    );
  }
}
