import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/adapter/adapter_blog.dart';
import 'package:yek_nahal/di/MainScope.dart';

class HomeTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeTab();
  }
}

class _HomeTab extends State<HomeTab> {
  String _token = "";

  @override
  void initState() {
    super.initState();

    ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget parent, MainScope model) {
        model.tokenSubject.listen((String token) {
          _token = token;
        });
      },
    );
  }

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
                  getHeaderCard(_token != ""),
                ],
              ),
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              margin: EdgeInsetsDirectional.only(start: 20),
              child: Text('آخرین مطالب'),
            ),
            Expanded(child: RowBlog()),
            Card(
              elevation: 12,
              child: Container(
                alignment: AlignmentDirectional.topCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image(
                      width: 60,
                      image: AssetImage('assets/images/ic_map_icon.png'),
                    ),
                    Text('مشاهده نقشه یک نهال'),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget getHeaderCard(bool isLoggedIn) {
    double cardHeight = 150;

    if (!isLoggedIn) {
      return Card(
        elevation: 15,
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Container(
              padding: EdgeInsetsDirectional.only(end: 5, bottom: 5),
              alignment: AlignmentDirectional.bottomEnd,
              child: Image(
                image: AssetImage('assets/images/ic_default_icon.png'),
                height: 80,
              ),
            ),
            Container(
              child: ListTile(
                contentPadding: EdgeInsets.all(15),
                title: Container(
                  child: Text('ورود / ثبت‌نام'),
                  margin: EdgeInsetsDirectional.only(bottom: 10),
                ),
                subtitle: Column(children: <Widget>[
                  Text(
                      'با عضویت در یک نهال خیلی راحت سفارش‌های خود را پیگیری کنید'),
                  Container(
                    alignment: AlignmentDirectional.bottomStart,
                    child: FlatButton(
                      child: Text(
                        'عضویت',
                      ),
                      textColor: Colors.white,
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        setState(() {
                          _token = "asfasf";
                        });
                      },
                    ),
                  )
                ]),
              ),
              height: cardHeight,
              alignment: AlignmentDirectional.bottomStart,
            ),
          ],
        ),
      );
    } else {
      return Card(
        elevation: 15,
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Container(
              padding: EdgeInsetsDirectional.only(end: 5, bottom: 5),
              alignment: AlignmentDirectional.bottomEnd,
              child: Image(
                image: AssetImage('assets/images/ic_default_icon.png'),
                height: 130,
              ),
            ),
            Container(
              height: cardHeight,
              alignment: AlignmentDirectional.centerStart,
              child: ListTile(
                contentPadding: EdgeInsets.all(15),
                title: Container(
                  child: Text('نهال کاشتهٔ من'),
                  margin: EdgeInsetsDirectional.only(bottom: 10),
                ),
                subtitle: Container(
                  child: Text("کاشته شده: ۵ نهال"),
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.centerEnd,
              margin: EdgeInsetsDirectional.only(end: 10, bottom: 10),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.share,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _token = "";
                  });
                },
              ),
            )
          ],
        ),
      );
    }
  }
}

class HalfCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.blue
      ..strokeWidth = size.width / 20
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(-100, -300), 200, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return null;
  }
}
