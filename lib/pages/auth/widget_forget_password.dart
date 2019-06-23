import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ForgetPasswordPage();
  }
}

class _ForgetPasswordPage extends State<ForgetPasswordPage> {


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
