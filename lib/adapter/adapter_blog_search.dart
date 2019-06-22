import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paging/paging.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainModels.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/models/blogs_response.dart';
import 'package:yek_nahal/utils/utils.dart';
import 'package:http/http.dart' as http;

class RowBlogSearch extends StatefulWidget {
  Function _onBlogClicked;

  RowBlogSearch(this._onBlogClicked);

  @override
  State<StatefulWidget> createState() {
    return _RowBlogSearch();
  }

}

class _RowBlogSearch extends State<RowBlogSearch>{

  List<BlogOb> blogs;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget child, MainModel model) {
        int itemCount = blogs.length;

        return Pagination<String>(
          pageBuilder: (currentSize) => requestGetPosts("",1,""),
          itemBuilder: _onBindView,
        );

        /*return ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: _onBindView,
          itemCount: itemCount,
        );*/
      },
    );
  }

  Widget _onBindView(int index, String item) {
    BlogOb blog = blogs[index];
    return GestureDetector(
      child: Container(
        width: 200,
        margin: EdgeInsets.all(10.0),
        child: Container(
          height: 300,
          width: 300,
          child: Card(
            elevation: 20,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                FadeInImage(
                  image: NetworkImage(blog.image),
                  placeholder: AssetImage(image_place_holder),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Card(
                  child: Column(children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: Container(
                        child: Text(blog.title),
                        margin: EdgeInsetsDirectional.only(bottom: 10),
                      ),
                      subtitle: Text(blog.body.substring(0,100)),
                    )
                  ],),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        widget._onBlogClicked(index);
      },
    );
  }


  Future requestGetPosts(String token, int page, String search) async {
    try {
      Map<String, String> header = {'Authorization': token};
      final http.Response response =
      await http.get(api_blog_search + "?page=$page&search=$search", headers: header);
      if (response.statusCode != 200 && response.statusCode != 201) {
        return false;
      } else {
        var result = json.decode(response.body);
        BlogSearchResponse temp = BlogSearchResponse.fromJson(result);
        blogs = temp.data.toList();
        return true;
      }
    } catch (error) {
      return false;
    }
  }
}
