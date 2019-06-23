import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yek_nahal/adapter/adapter_blog.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/models/blogs_response.dart';
import 'package:yek_nahal/pages/page_auth.dart';
import 'package:yek_nahal/utils/routs.dart';
import 'package:yek_nahal/utils/utils.dart';

class HomeTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeTab();
  }
}

class _HomeTab extends State<HomeTab> {
  String _token = "";
  List<BlogOb> blogs = [];

  @override
  void initState() {
    super.initState();
    getToken().then((token) {
      _token = token;
      requestGetPosts(_token, 1).then((value) {
        if (value as bool != false) {
        } else {
          //TODO: make error handler widget
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget parent, MainScope model) {
        return SingleChildScrollView(
          child: Column(
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
              loadBlogs(model, blogs.length != 0),
              Card(
                margin: EdgeInsetsDirectional.only(top: 50, start: 20, end: 20),
                elevation: 7,
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
          ),
        );
      },
    );
  }

  Widget loadBlogs(MainScope model, bool isBlogLoaded) {
    if (isBlogLoaded) {
      return Container(
          height: 200,
          child: Row(
            children: <Widget>[
              Expanded(child: RowBlog(blogs, _onBlogClicked)),
            ],
          ));
    } else {
      return Center(child: CircularProgressIndicator());
    }
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
                    'با عضویت در یک نهال خیلی راحت سفارش‌های خود را پیگیری کنید',
                    style: TextStyle(
                      height: 1.2,
                      fontSize: 13,
                    ),
                  ),
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
                        Navigator.pushNamed(
                          context,
                          rout_auth,
                          arguments: PageState.login,
                        );
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

  Future requestGetPosts(String token, int page) async {
    try {
      Map<String, String> header = {'Authorization': token};
      final http.Response response =
          await http.get(api_blog + "?page=$page", headers: header);
      if (response.statusCode != 200 && response.statusCode != 201) {
        return false;
      } else {
        var result = json.decode(response.body);
        BlogSearchResponse temp = BlogSearchResponse.fromJson(result);
        setState(() {
          blogs = temp.data.toList();
        });
        return true;
      }
    } catch (error) {
      return false;
    }
  }

  void _onBlogClicked(int index) {
    Navigator.pushNamed(
      context,
      rout_blog,
      arguments: blogs[index],
    );
  }

  Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(shared_token) ?? "";
  }
}
