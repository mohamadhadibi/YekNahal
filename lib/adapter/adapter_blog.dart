import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainModels.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/models/blogs_response.dart';

class RowBlog extends StatelessWidget {
  BlogOb model;
  List<BlogOb> blogs;
  RowBlog(this.blogs);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget child, MainModel model) {
        int itemCount = blogs.length;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: _onBindView,
          itemCount: itemCount,
        );

      },
    );
  }

  Widget _onBindView(BuildContext context, int index) {
    BlogOb blog = blogs[index];
    return Container(
      width: 200,
      margin: EdgeInsets.all(10.0),
      child: Card(
        elevation: 20,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            FadeInImage(
              placeholder: NetworkImage(blog.image),
              image: AssetImage(blog.image),
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            Image.asset('assets/images/ic_row_mask.png', width: 200,),
            Text(blog.title),
          ],
        ),
      ),
    );
  }

}
