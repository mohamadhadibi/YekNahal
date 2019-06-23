import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paging/paging.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainModels.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/models/blogs_response.dart';
import 'package:yek_nahal/utils/utils.dart';

class RowBlogSearch extends StatefulWidget {
  Function _onBlogClicked;
  String _strSearch = "";

  RowBlogSearch(this._onBlogClicked, this._strSearch);

  @override
  State<StatefulWidget> createState() {
    return _RowBlogSearch();
  }
}

class _RowBlogSearch extends State<RowBlogSearch> {
  List<BlogOb> blogs = [];
  String _token = "";
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Pagination<BlogOb>(
          pageBuilder: (currentSize) =>
              requestGetPosts(_token, widget._strSearch, currentSize),
          itemBuilder: _onBindView,
        );
      },
    );
  }

  Widget _onBindView(int index, BlogOb blog) {
    double myWidth = 200;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 250,
        child: Stack(
          children: <Widget>[
            Align(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: FadeInImage(
                  image: NetworkImage(blog.image),
                  placeholder: AssetImage(image_place_holder),
                  height: 250,
                  width: myWidth,
                  fit: BoxFit.cover,
                ),
              ),
              alignment: AlignmentDirectional.centerStart,
            ),
            Align(
              child: Container(
                width: myWidth,
                height: myWidth,
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.all(10),
                        title: Container(
                          child: Text(blog.title),
                          margin: EdgeInsetsDirectional.only(bottom: 10),
                        ),
                        subtitle: Text(blog.body.substring(0, 100) + "..."),
                      )
                    ],
                  ),
                ),
              ),
              alignment: AlignmentDirectional.centerEnd,
            ),
          ],
        ),
      ),
      onTap: () {
        widget._onBlogClicked(blog);
      },
    );
  }

  Future<List<BlogOb>> requestGetPosts(String token, String search, int currentSize) async {
    try {
      Map<String, String> header = {'Authorization': token};
      final http.Response response = await http
          .get(api_blog_search + "?page=$page&search=$search", headers: header);
      if (response.statusCode != 200 && response.statusCode != 201) {
        return blogs;
      } else {
        var result = json.decode(response.body);
        BlogSearchResponse temp = BlogSearchResponse.fromJson(result);
        blogs = temp.data.toList();
        page++;

        return blogs;
      }
    } catch (error) {
      return blogs;
    }
  }
}
