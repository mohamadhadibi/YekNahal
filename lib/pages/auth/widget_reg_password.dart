import 'package:flutter/material.dart';

class RegPasswordPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _RegPasswordPage();
  }
}

class _RegPasswordPage extends State<RegPasswordPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Container(
          alignment: AlignmentDirectional.center,
          margin: EdgeInsetsDirectional.only(end: 50),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(),
    );
  }

}
