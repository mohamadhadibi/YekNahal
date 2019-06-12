import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeTab();
  }

}

class _HomeTab extends State<HomeTab>{

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        //alignment:new Alignment(x, y)
        children: <Widget>[
          new Icon(Icons.monetization_on, size: 36.0, color: const Color.fromRGBO(218, 165, 32, 1.0)),
          new Positioned(
            left: 20.0,
            child: new Icon(Icons.monetization_on, size: 36.0, color: const Color.fromRGBO(218, 165, 32, 1.0)),
          ),
          new Positioned(
            left:40.0,
            child: new Icon(Icons.monetization_on, size: 36.0, color: const Color.fromRGBO(218, 165, 32, 1.0)),
          )

        ],
      ),
    );
  }

}