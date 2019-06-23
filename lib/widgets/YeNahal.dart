import 'package:flutter/material.dart';

class YeNahal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsetsDirectional.only(bottom: 10, end: 20),
                height: 70,
                width: 70,
                child: Image.asset('assets/images/ic_logo.png'),
              ),
              Text(
                'یک نهال',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.teal,
                  fontFamily: 'IranSans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Text(
            '#هدیه_به_زمین',
            style: TextStyle(
              color: Colors.grey,
              fontFamily: 'IranSans',
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
