import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BlogPage();
  }

}

class _BlogPage extends State<BlogPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Text('hellow'),
      ),
    );
  }

}