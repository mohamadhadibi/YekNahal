import 'package:flutter/material.dart';

AppBar makeAppbar(String title, BuildContext context){
  return AppBar(
    automaticallyImplyLeading: true,
    title: Container(
      alignment: AlignmentDirectional.center,
      margin: EdgeInsetsDirectional.only(end: 50),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14,
        ),
      ),
    ),
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black87,
      ),
      onPressed: () => Navigator.pop(context, false),
    ),
    backgroundColor: Colors.white,
  );
}
